using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;

namespace eBarberShop.Services.Servisi
{
    public class RecommendService : IRecommendService
    {
        private readonly ApplicationDbContext _dbContext;
        private readonly IMapper _mapper;

        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public RecommendService(ApplicationDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public void TrainModel()
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var narudzbeData = _dbContext.Narudzbe.Include(x => x.NarudzbeDetalji).ToList();

                    var data = new List<ProductEntry>();

                    foreach (var item in narudzbeData)
                    {
                        if (item.NarudzbeDetalji.Count > 1)
                        {
                            var distinctItemId = item.NarudzbeDetalji.Select(x => x.ProizvodId).ToList();

                            foreach (var y in distinctItemId)
                            {
                                var relatedItems = item.NarudzbeDetalji.Where(z => z.ProizvodId != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new ProductEntry()
                                    {
                                        ProductID = (uint)y,
                                        CoPurchaseProductID = (uint)z.ProizvodId,
                                    });
                                }
                            }
                        }
                    }

                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                    options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    // For better results use the following parameters
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(traindata);
                }
            }
        }

        public List<Proizvodi> RecommendProizvodi(int id)
        {
            if (model == null)
            {
                TrainModel();
            }

            var proizvodi = _dbContext.Proizvodi.Include("VrstaProizvoda").Where(x => x.ProizvodiId != id && x.Status == true);
            var predictionResult = new List<Tuple<Database.Proizvodi, float>>();

            foreach (var proizvod in proizvodi)
            {
                var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
                var prediction = predictionengine.Predict(new ProductEntry
                {
                    ProductID = (uint)id,
                    CoPurchaseProductID = (uint)proizvod.ProizvodiId
                });

                predictionResult.Add(new Tuple<Database.Proizvodi, float>(proizvod, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return _mapper.Map<List<Model.Proizvodi>>(finalResult);
        }

        public class Copurchase_prediction
        {
            public float Score { get; set; }
        }

        public class ProductEntry
        {
            [KeyType(count: 10)]
            public uint ProductID { get; set; }

            [KeyType(count: 10)]
            public uint CoPurchaseProductID { get; set; }

            public float Label { get; set; }
        }
    }
}
