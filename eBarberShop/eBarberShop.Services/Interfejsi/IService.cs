using eBarberShop.Model;
using eBarberShop.Model.Search;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Interfejsi
{
    public interface IService<T, TSearch> where T : class where TSearch : BaseSearch
    {
        Task<PagedResult<T>> Get(TSearch? search);
        Task<T> GetById(int id);
    }
}
