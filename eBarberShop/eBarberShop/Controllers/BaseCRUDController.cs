using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : BaseSearch
    {
        protected new ICRUDService<T, TSearch, TInsert, TUpdate> _service;
        protected new ILogger<BaseCRUDController<T, TSearch, TInsert, TUpdate>> _logger;

        public BaseCRUDController(ILogger<BaseCRUDController<T, TSearch, TInsert, TUpdate>> logger, ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(logger, service)
        {
            _service = service;
            _logger = logger;
        }

        [HttpPost]
        public virtual async Task<T> Insert([FromBody] TInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, [FromBody] TUpdate update)
        {
            return await _service.Update(id, update);
        }

        [HttpDelete("{id}")]
        public virtual async Task<T> Delete(int id)
        {
            return await _service.Delete(id);
        }
    }
}
