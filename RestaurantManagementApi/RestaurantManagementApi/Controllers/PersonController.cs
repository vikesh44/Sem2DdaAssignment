using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;

namespace RestaurantManagementApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PersonController : Controller
    {
        [HttpGet]
        [Route("{personId}")]
        public async Task<IActionResult> GetPersonDetails([FromRoute] string personId)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonId", personId)
            };
            return Ok(await DbHelper.Instance.GetData<PersonDetails>("SSP_GetCustomerDetail", parameters));
        }

        [HttpGet]
        [Route("GetEmployees")]
        public async Task<IActionResult> GetEmployees()
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@IsCustomer", false)
            };
            return Ok(await DbHelper.Instance.GetData<PersonDetails>("SSP_GetPersons", parameters));
        }

        [HttpGet]
        [Route("GetCustomers")]
        public async Task<IActionResult> GetCustomers()
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@IsCustomer", true)
            };
            return Ok(await DbHelper.Instance.GetData<PersonDetails>("SSP_GetPersons", parameters));
        }

        [HttpPut]
        [Route("{personId}")]
        public async Task<IActionResult> UpdatePersonAccount([FromRoute] string personId, SavePersonDetails personDetails)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonId", personId),
                new ProcedureParameter ("@UserName", personDetails.UserName),
                new ProcedureParameter ("@Password", personDetails.Password),
                new ProcedureParameter ("@EmailId", personDetails.EmailId),
                new ProcedureParameter ("@DateOfBirth", personDetails.DateOfBirth.ToString("yyyy-MM-dd")),
                new ProcedureParameter ("@FirstName", personDetails.FirstName),
                new ProcedureParameter ("@LastName", personDetails.LastName),
                new ProcedureParameter ("@PhoneNo", personDetails.PhoneNo),
            };

            int insertedRecords = await DbHelper.Instance.UpdateData("SSP_UpdatePerson", parameters);

            return insertedRecords >= 1 ? Ok(personDetails) : Content("Error creating updating person");
        }

        [HttpDelete]
        [Route("{personId}/{isCustomer}")]
        public async Task<IActionResult> DeletePerson([FromRoute] string personId, [FromRoute] bool isCustomer)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonId", personId),
                new ProcedureParameter ("@IsCustomer", isCustomer)
            };

            int deletedRecords = await DbHelper.Instance.UpdateData("SSP_DeletePerson", parameters);

            return deletedRecords >= 1 ? Ok() : this.Content("Error deleting user.");
        }
    }
}
