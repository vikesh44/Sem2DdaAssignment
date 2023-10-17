using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;

namespace RestaurantManagementApi.Controllers
{
    [ApiController, Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    public class MenuController : Controller
    {
        [HttpGet]
        public async Task<IActionResult> GetMenu()
        {
            return Ok(await DbHelper.Instance.GetData<Menu>("SSP_GetMenu"));
        }

        [HttpPost]
        public async Task<IActionResult> AddMenuItem(Menu menuItem)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@ItemId", menuItem.ItemId),
                new ProcedureParameter ("@Category", menuItem.Category),
                new ProcedureParameter ("@Name", menuItem.Name),
                new ProcedureParameter ("@Cost", menuItem.Cost),
                new ProcedureParameter ("@IsAvailable", menuItem.IsAvailable),
            };

            int updatedRecords = await DbHelper.Instance.UpdateData("SSP_AddUpdateMenuItem", parameters);

            return updatedRecords >= 1 ? Ok(menuItem) : Content("Error creating new menu item");
        }

        [HttpPut]
        [Route("{menuItemId}")]
        public async Task<IActionResult> UpdateMenuItem([FromRoute] string menuItemId, UpdateMenu menuItem)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@ItemId", menuItemId),
                new ProcedureParameter ("@Category", menuItem.Category),
                new ProcedureParameter ("@Name", menuItem.Name),
                new ProcedureParameter ("@Cost", menuItem.Cost),
                new ProcedureParameter ("@IsAvailable", menuItem.IsAvailable),
            };

            int updatedRecords = await DbHelper.Instance.UpdateData("SSP_AddUpdateMenuItem", parameters);

            return updatedRecords >= 1 ? Ok(menuItem) : Content("Error updating menu item");
        }

        [HttpDelete]
        [Route("{menuItemId}")]
        public async Task<IActionResult> DeleteMenuItem([FromRoute] string menuItemId)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@ItemId", menuItemId)
            };

            int deletedRecords = await DbHelper.Instance.UpdateData("SSP_DeleteMenuItem", parameters);

            return deletedRecords >= 1 ? Ok() : this.Content("Error deleting menu item");
        }
    }
}
