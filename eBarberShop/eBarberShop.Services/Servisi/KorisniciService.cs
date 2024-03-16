using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Helper;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class KorisniciService : BaseCRUDService<Model.Korisnici, Database.Korisnici, Model.Search.KorisniciSearch, Model.Requests.KorisniciInsertRequest, Model.Requests.KorisniciUpdateRequest>, IKorisniciService
    {
        public KorisniciService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override async Task BeforeInsert(Database.Korisnici entity, KorisniciInsertRequest insert)
        {
            entity.LozinkaSalt = PasswordHelper.GenerateSalt();
            entity.LozinkaHash = PasswordHelper.GenerateHash(entity.LozinkaSalt, insert.Lozinka);
        }

        public override IQueryable<Database.Korisnici> AddFilter(IQueryable<Database.Korisnici> query, KorisniciSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                query = query.Where(x => x.Ime.ToLower().StartsWith(search.Ime.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(search?.Prezime))
            {
                query = query.Where(x => x.Prezime.ToLower().StartsWith(search.Prezime.ToLower()));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Korisnici> AddInclude(IQueryable<Database.Korisnici> query, KorisniciSearch? search)
        {
            if (search?.IsUlogeIncluded == true)
            {
                query = query.Include("KorisniciUloge.Uloga");
            }

            return base.AddInclude(query, search);
        }

        public async Task<Model.Korisnici> Login(string username, string password)
        {
            var user = await _dbContext.Korisnici
                .Include("KorisniciUloge.Uloga")
                .Where(x => x.KorisnickoIme == username)
                .FirstOrDefaultAsync();

            if (user != null)
            {
                var hash = Helper.PasswordHelper.GenerateHash(user.LozinkaSalt, password);
                if (hash == user.LozinkaHash)
                    return _mapper.Map<Model.Korisnici>(user);
            }

            throw new UserException("Korisnicko ime ili lozinka nisu ispravni!");
        }

        public override async Task<Model.Korisnici> GetById(int id)
        {
            var data = await _dbContext.Set<Database.Korisnici>().Include("Grad").FirstOrDefaultAsync(x => x.KorisniciId == id);

            if (data == null)
                return null;

            return _mapper.Map<Model.Korisnici>(data);
        }

        public override async Task BeforeUpdate(Database.Korisnici entity, KorisniciUpdateRequest update)
        {
            if (update.Lozinka != "")
            {
                var salt = PasswordHelper.GenerateSalt();
                entity.LozinkaSalt = salt;
                entity.LozinkaHash = PasswordHelper.GenerateHash(salt, update.Lozinka);
            }
        }
    }
}
