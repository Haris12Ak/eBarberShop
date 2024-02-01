using eBarberShop.Model;
using eBarberShop.Model.Search;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Interfejsi
{
    public interface IDrzavaService : IService<Model.Drzava, Model.Search.BaseSearch>
    {
        
    }
}
