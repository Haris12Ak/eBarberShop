using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [Route("api/[controller]")]
    public class BaseCRUDController<T, TInsert, TUpdate> : BaseController<T> where T : class
    {
        protected new ICRUDService<T, TInsert, TUpdate> _service;
        protected new ILogger<BaseCRUDController<T, TInsert, TUpdate>> _logger;

        public BaseCRUDController(ILogger<BaseCRUDController<T, TInsert, TUpdate>> logger, ICRUDService<T, TInsert, TUpdate> service) : base(logger, service)
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
