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

        [HttpPost]
        public async Task<IActionResult> CreatePersonAccount(PersonDetails personDetails)
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

            int insertedRecords = await DbHelper.Instance.UpdateData("SSP_AddPerson", parameters);

            return insertedRecords >= 1 ? Ok(personDetails) : Content("Error creating new person");
        }

        [HttpPut]
        [Route("{personId}")]
        public async Task<IActionResult> UpdatePersonAccount([FromRoute] string personId, PersonDetails personDetails)
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

            int insertedRecords = await DbHelper.Instance.UpdateData("SSP_UpdateCustomer", parameters);

            return insertedRecords >= 1 ? Ok(personDetails) : Content("Error creating updating person");
        }
    }
}
