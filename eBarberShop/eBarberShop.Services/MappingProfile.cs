using AutoMapper;

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

            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();

            CreateMap<Database.Uloge, Model.Uloge>();

            CreateMap<Database.VrsteProizvoda, Model.VrsteProizvoda>();
            CreateMap<Model.Requests.VrsteProizvodaInsertRequest, Database.VrsteProizvoda>();
            CreateMap<Model.Requests.VrsteProizvodaUpdateRequest, Database.VrsteProizvoda>();

            CreateMap<Database.Proizvodi, Model.Proizvodi>();
            CreateMap<Model.Requests.ProizvodiInsertRequest, Database.Proizvodi>();
            CreateMap<Model.Requests.ProizvodiUpdateRequest, Database.Proizvodi>();

            CreateMap<Database.Novosti, Model.Novosti>();
            CreateMap<Model.Requests.NovostiInsertRequest, Database.Novosti>();
            CreateMap<Model.Requests.NovostiUpdateRequest, Database.Novosti>();

            CreateMap<Database.Recenzije, Model.Recenzije>();
            CreateMap<Model.Requests.RecenzijeInsertRequest, Database.Recenzije>();
            CreateMap<Model.Requests.RecenzijeUpdateRequest, Database.Recenzije>();

            CreateMap<Database.Uposlenik, Model.Uposlenik>();
            CreateMap<Model.Requests.UposlenikInsertRequest, Database.Uposlenik>();
            CreateMap<Model.Requests.UposlenikUpdateRequest, Database.Uposlenik>();

            CreateMap<Database.Usluga, Model.Usluga>();
            CreateMap<Model.Requests.UslugaInsertRequest, Database.Usluga>();
            CreateMap<Model.Requests.UslugaUpdateRequest, Database.Usluga>();

            CreateMap<Database.Rezervacija, Model.Rezervacija>();
            CreateMap<Model.Requests.RezervacijaInsertRequest, Database.Rezervacija>();
            CreateMap<Model.Requests.RezervacijaUpdateRequest, Database.Rezervacija>();

            CreateMap<Database.Slike, Model.Slike>();
            CreateMap<Model.Requests.SlikeInsertRequest, Database.Slike>();
            CreateMap<Model.Requests.SlikeUpdateRequest, Database.Slike>();

            CreateMap<Database.Narudzbe, Model.Narudzbe>();
            CreateMap<Model.Requests.NarudzbeInsertRequest, Database.Narudzbe>();
            CreateMap<Model.Requests.NarudzbeUpdateRequest, Database.Narudzbe>();

            CreateMap<Database.Kosarica, Model.Kosarica>();
            CreateMap<Model.Requests.KosaricaInsertRequest, Database.Kosarica>();
            CreateMap<Model.Requests.KosaricaUpdateRequest, Database.Kosarica>();

            CreateMap<Database.NarudzbeDetalji, Model.NarudzbeDetalji>();

            CreateMap<Database.RezervacijaUsluge, Model.UslugaRezervacije>();
            CreateMap<Database.RezervacijaUsluge, Model.RezervacijaUsluge>();
            CreateMap<Model.Requests.RezervacijaUslugeInsertRequest, Database.RezervacijaUsluge>();
            CreateMap<Model.Requests.RezervacijaUslugeUpdateRequest, Database.RezervacijaUsluge>();

            CreateMap<Database.Rezervacija, Model.Termini>();

            CreateMap<Database.SlikeUsluge, Model.SlikeUsluge>();
            CreateMap<Model.Requests.SlikeUslugeInsertRequest, Database.SlikeUsluge>();
            CreateMap<Model.Requests.SlikeUslugeUpdateRequest, Database.SlikeUsluge>();

            CreateMap<Database.Ocjene, Model.Ocjene>();
            CreateMap<Model.Requests.OcjeneInsertRequest, Database.Ocjene>();
            CreateMap<Model.Requests.OcjeneUpdateRequest, Database.Ocjene>();
        }
    }
}
