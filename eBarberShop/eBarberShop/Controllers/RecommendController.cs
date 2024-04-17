using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]
    public class RecommendController : ControllerBase
    {
        private readonly IRecommendService _recommendService;

        public RecommendController(IRecommendService recommendService)
        {
            _recommendService = recommendService;
        }

        [HttpGet("/RecommendProizvodi/{id}")]
        public List<Model.Proizvodi> RecommendProizvodi(int id)
        {
            return _recommendService.RecommendProizvodi(id);
        }
    }
}
