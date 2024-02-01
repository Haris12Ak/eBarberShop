using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [Route("[controller]")]
    public class BaseController<T> : ControllerBase where T : class
    {
        protected IService<T> _service;
        protected ILogger<BaseController<T>> _logger;

        public BaseController(ILogger<BaseController<T>> logger, IService<T> service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet]
        public virtual async Task<List<T>> Get()
        {
            return await _service.Get();
        }

        [HttpGet("{id}")]
        public virtual async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
