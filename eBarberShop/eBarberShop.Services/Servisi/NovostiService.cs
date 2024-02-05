using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Database;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class NovostiService : BaseCRUDService<Model.Novosti, Database.Novosti, Model.Search.NovostiSearch, Model.Requests.NovostiInsertRequest, Model.Requests.NovostiUpdateRequest>, INovostiService
    {
        public NovostiService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Novosti> AddFilter(IQueryable<Novosti> query, NovostiSearch? search)
        {
            if (search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumObjave.Date == search.DatumObjave.Value.Date);
            }

            return base.AddFilter(query, search);
        }
    }
}
