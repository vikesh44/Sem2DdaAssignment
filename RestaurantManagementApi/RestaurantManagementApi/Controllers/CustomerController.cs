using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;

namespace RestaurantManagementApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CustomerController : Controller
    {
        [HttpPost]
        public async Task<IActionResult> CreateCustomerAccount(PersonDetails personDetails)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@UserName", personDetails.UserName),
                new ProcedureParameter ("@Password", personDetails.Password),
                new ProcedureParameter ("@EmailId", personDetails.EmailId),
                new ProcedureParameter ("@DateOfBirth", personDetails.DateOfBirth.ToString("yyyy-MM-dd")),
                new ProcedureParameter ("@FirstName", personDetails.FirstName),
                new ProcedureParameter ("@LastName", personDetails.LastName),
                new ProcedureParameter ("@PhoneNo", personDetails.PhoneNo),
            };

            int insertedRecords = await DbHelper.Instance.UpdateData("SSP_AddCustomer", parameters);

            return insertedRecords >= 1 ? Ok(personDetails) : Content("Error creating new person");
        }
    }
}
