using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;

namespace RestaurantManagementApi.Controllers
{
    [ApiController, Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
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
