using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Interfejsi
{
    public interface INovostiService : ICRUDService<Novosti, NovostiSearch, NovostiInsertRequest, NovostiUpdateRequest>
    {
    }
}
