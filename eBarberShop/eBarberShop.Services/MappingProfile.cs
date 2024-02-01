using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Drzava, Model.Drzava>();

            CreateMap<Database.Grad, Model.Grad>();

            CreateMap<Database.Korisnici, Model.Korisnici>();
            CreateMap<Model.Requests.KorisniciInsertRequest, Database.Korisnici>();
            CreateMap<Model.Requests.KorisniciUpdateRequest, Database.Korisnici>();

            CreateMap<Database.Uloge, Model.Uloge>();

        }
    }
}
