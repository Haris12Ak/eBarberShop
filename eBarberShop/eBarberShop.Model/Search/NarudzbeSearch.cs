using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Search
{
    public class NarudzbeSearch : BaseSearch
    {
        public string? BrojNarudzbe { get; set; }
        public DateTime? DatumNarudzbe { get; set; }
    }
}
