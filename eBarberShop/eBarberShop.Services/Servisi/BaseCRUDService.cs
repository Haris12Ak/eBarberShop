﻿using AutoMapper;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class BaseCRUDService<T, Tdb, TInsert, TUpdate> : BaseService<T, Tdb> where T : class where Tdb : class
    {
        public BaseCRUDService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _dbContext.Set<Tdb>();

            Tdb entity = _mapper.Map<Tdb>(insert);

            await set.AddAsync(entity);

            await BeforeInsert(entity, insert);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }


        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = _dbContext.Set<Tdb>();

            var entity = await set.FindAsync(id);

            if (entity == null)
                return null;

            _mapper.Map(update, entity);
            await _dbContext.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }

        public virtual async Task<T> Delete(int id)
        {
            var set = _dbContext.Set<Tdb>();

            var entity = await set.FindAsync(id);

            if (entity == null)
                return null;

            set.Remove(entity);
            await _dbContext.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }

        
        public virtual async Task BeforeInsert(Tdb entity, TInsert insert)
        {
            
        }
        
    }
}
