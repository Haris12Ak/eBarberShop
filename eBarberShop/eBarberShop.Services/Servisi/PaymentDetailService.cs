using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class PaymentDetailService : BaseCRUDService<Model.PaymentDetail, Database.PaymentDetail, Model.Search.BaseSearch, Model.Requests.PaymentDetailInsertRequest, Model.Requests.PaymentDetailUpdateRequest>, IPaymentDetailService
    {
        public PaymentDetailService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<PaymentDetail> GetByNarudzbaId(int narudzbaId)
        {
            var data = await _dbContext.Set<Database.PaymentDetail>().Where(x => x.NarudzbaId == narudzbaId).FirstOrDefaultAsync();

            if (data == null)
                return null;

            return _mapper.Map<Model.PaymentDetail>(data);
        }
    }
}
