using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : BaseSearch
    {
        protected IService<T, TSearch> _service;
        protected ILogger<BaseController<T, TSearch>> _logger;

        public BaseController(ILogger<BaseController<T, TSearch>> logger, IService<T, TSearch> service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet]
        public virtual async Task<PagedResult<T>> Get([FromQuery] TSearch? search)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public virtual async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
