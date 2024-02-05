using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Requests
{
    public class RecenzijeInsertRequest
    {
        public string Sadrzaj { get; set; }
        public int Ocjena { get; set; }
        public DateTime DatumObjave { get; set; }
        public int KorisnikId { get; set; }
    }
}
