using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Search;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class BaseService<T, Tdb, TSearch> where T : class where Tdb : class where TSearch : BaseSearch
    {
        protected ApplicationDbContext _dbContext;
        protected IMapper _mapper;

        public BaseService(ApplicationDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch? search)
        {
            var query =  _dbContext.Set<Tdb>().AsQueryable();

            PagedResult<T> result = new PagedResult<T>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if(search?.PageSize.HasValue == true && search?.Page.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<T>>(list);

            return result;
        }

        public virtual IQueryable<Tdb> AddFilter(IQueryable<Tdb> query, TSearch? search)
        {
            return query;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await _dbContext.Set<Tdb>().FindAsync(id);

            if (entity == null)
                return null;

            return _mapper.Map<T>(entity);
        }
    }
}
