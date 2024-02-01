using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Interfejsi
{
    public interface ICRUDService<T, TInsert, TUpdate> : IService<T> where T : class
    {
        Task<T> Insert(TInsert insert);
        Task<T> Update(int id, TUpdate update);
        Task<T> Delete(int id);
    }
}
