using AutoMapper;
using eBarberShop.Model.Search;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class BaseCRUDService<T, Tdb, TSearch, TInsert, TUpdate> : BaseService<T, Tdb, TSearch> where T : class where Tdb : class where TSearch : BaseSearch
    {
        public BaseCRUDService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _dbContext.Set<Tdb>();

            await CheckIfUsernameExist(set, insert);

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

            await BeforeUpdate(entity, update);

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
        public virtual async Task BeforeUpdate(Tdb entity, TUpdate update)
        {

        }

        public virtual async Task CheckIfUsernameExist(DbSet<Tdb> set, TInsert insert)
        {

        }


    }
}
