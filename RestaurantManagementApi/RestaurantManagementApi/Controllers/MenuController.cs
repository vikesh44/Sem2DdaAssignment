using Microsoft.AspNetCore.Mvc;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;

namespace RestaurantManagementApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MenuController : Controller
    {
        [HttpGet]
        public async Task<IActionResult> GetUsers()
        {
            return Ok(await DbHelper.Instance.GetData<Menu>("SSP_GetMenu"));
        }
    }
}
