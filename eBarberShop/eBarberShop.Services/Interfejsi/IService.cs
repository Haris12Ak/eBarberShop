using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Interfejsi
{
    public interface IService<T> where T : class
    {
        Task<List<T>> Get();
        Task<T> GetById(int id);
    }
}
