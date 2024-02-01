using AutoMapper;
using eBarberShop.Model.Requests;
using eBarberShop.Services.Database;
using eBarberShop.Services.Helper;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class KorisniciService : BaseCRUDService<Model.Korisnici, Database.Korisnici, Model.Requests.KorisniciInsertRequest, Model.Requests.KorisniciUpdateRequest>, IKorisniciService
    {
        public KorisniciService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override async Task BeforeInsert(Korisnici entity, KorisniciInsertRequest insert)
        {
            entity.LozinkaSalt = PasswordHelper.GenerateSalt();
            entity.LozinkaHash = PasswordHelper.GenerateHash(entity.LozinkaSalt, insert.Lozinka);
        }

    }
}
