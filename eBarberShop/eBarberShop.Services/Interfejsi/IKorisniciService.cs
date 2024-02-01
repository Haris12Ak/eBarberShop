using eBarberShop.Model.Search;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Interfejsi
{
    public interface IKorisniciService : ICRUDService<Model.Korisnici, Model.Search.KorisniciSearch, Model.Requests.KorisniciInsertRequest, Model.Requests.KorisniciUpdateRequest>
    {

    }
}
