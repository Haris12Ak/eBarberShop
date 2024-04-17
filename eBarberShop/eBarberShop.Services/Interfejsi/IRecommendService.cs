namespace eBarberShop.Services.Interfejsi
{
    public interface IRecommendService
    {
        void TrainModel();
        List<Model.Proizvodi> RecommendProizvodi(int id);
    }
}
