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
    public class RecenzijeService : BaseCRUDService<Model.Recenzije, Database.Recenzije, Model.Search.RecenzijeSearch, Model.Requests.RecenzijeInsertRequest, Model.Requests.RecenzijeUpdateRequest>, IRecenzijeService
    {
        public RecenzijeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Recenzije> AddFilter(IQueryable<Recenzije> query, RecenzijeSearch? search)
        {
            if(search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumObjave.Date == search.DatumObjave.Value.Date);
            }

            return base.AddFilter(query, search);
        }
    }
}
