using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;

namespace RestaurantManagementApi.Controllers
{
    [ApiController, Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    public class OrderController : Controller
    {

        [HttpPost]
        public async Task<IActionResult> CreateOrder(Order order)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@OrderType", order.OrderType),
                new ProcedureParameter ("@CustomerId", order.CustomerId),
                new ProcedureParameter ("@EmployeeId", order.EmployeeId),
                new ProcedureParameter ("@TableId", order.TableId),
                new ProcedureParameter ("@IsReservation", order.IsReservation)
            };

            int updatedRecords = await DbHelper.Instance.UpdateData("SSP_CreateOrder", parameters);

            return updatedRecords >= 1 ? Ok(order) : Content("Error creating new menu item");
        }

        [HttpGet]
        [Route("{personId}/{isCustomer}/{isCompleted}")]
        public async Task<IActionResult> GetPersonOrders([FromRoute] string personId, [FromRoute] bool isCustomer, [FromRoute] bool isCompleted)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonId", personId),
                new ProcedureParameter ("@IsCustomer", isCustomer),
                new ProcedureParameter ("@IsCompleted", isCompleted),
            };
            return Ok(await DbHelper.Instance.GetData<PersonOrders>("SSP_GetPersonOrders", parameters));
        }
    }
}
