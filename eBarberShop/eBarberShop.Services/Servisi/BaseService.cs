using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class BaseService<T, Tdb> where T : class where Tdb : class
    {
        protected ApplicationDbContext _dbContext;
        protected IMapper _mapper;

        public BaseService(ApplicationDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public virtual async Task<List<T>> Get()
        {
            var entity = await _dbContext.Set<Tdb>().ToListAsync();

            return _mapper.Map<List<T>>(entity);
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
