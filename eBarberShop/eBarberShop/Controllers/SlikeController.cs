using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class SlikeController : BaseCRUDController<Slike, SlikeSearch, SlikeInsertRequest, SlikeUpdateRequest>
    {
        public SlikeController(ILogger<BaseCRUDController<Slike, SlikeSearch, SlikeInsertRequest, SlikeUpdateRequest>> logger, ISlikeService service) : base(logger, service)
        {
        }
    }
}
