using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RestaurantManagementApi.DTO;
using RestaurantManagementApi.Helper;
using System.Data;

namespace RestaurantManagementApi.Controllers
{
    [ApiController, Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    [Route("api/[controller]")]
    public class PersonAddressController : Controller
    {
        [HttpGet]
        [Route("{personId}")]
        public async Task<IActionResult> GetPersonAddress([FromRoute] string personId)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonId", personId)
            };

            return Ok(await DbHelper.Instance.GetData<PersonAddress>("SSP_GetPersonAddress", parameters));
        }

        [HttpPost]
        public async Task<IActionResult> AddPersonAddress(PersonAddress personAddress)
        {
            DataTable dataTable = new();
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_INT64), "PersonId"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_INT32), "AddressNo"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "HouseNo"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "Area"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "City"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "Zip"));

            DataRow dtRow = dataTable.NewRow();
            dtRow["PersonId"] = personAddress.PersonId;
            dtRow["AddressNo"] = personAddress.AddressNo;
            dtRow["HouseNo"] = personAddress.HouseNo;
            dtRow["Area"] = personAddress.Area;
            dtRow["City"] = personAddress.City;
            dtRow["Zip"] = personAddress.Zip;
            dataTable.Rows.Add(dtRow);

            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonAddress", dataTable)
            };

            int updatedRecords = await DbHelper.Instance.UpdateData("SSP_AddUpdatePersonAddress", parameters);

            return updatedRecords >= 1 ? Ok(personAddress) : Content("Error creating new address");
        }

        private static DataColumn CreateDataColumn(Type? dataType, string columnName)
        {
            DataColumn dtColumn;
            // Create OrderId column
            dtColumn = new DataColumn
            {
                DataType = dataType,
                ColumnName = columnName
            };
            return dtColumn;
        }

        [HttpPut]
        [Route("{personId}")]
        public async Task<IActionResult> UpdateMenuItem([FromRoute] string personId, PersonAddress personAddress)
        {
            DataTable dataTable = new();
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_INT64), "PersonId"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_INT32), "AddressNo"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "HouseNo"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "Area"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "City"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "Zip"));

            DataRow dtRow = dataTable.NewRow();
            dtRow["PersonId"] = personId;
            dtRow["AddressNo"] = personAddress.AddressNo;
            dtRow["HouseNo"] = personAddress.HouseNo;
            dtRow["Area"] = personAddress.Area;
            dtRow["City"] = personAddress.City;
            dtRow["Zip"] = personAddress.Zip;
            dataTable.Rows.Add(dtRow);

            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonAddress", dataTable)
            };

            int updatedRecords = await DbHelper.Instance.UpdateData("SSP_AddUpdatePersonAddress", parameters);

            return updatedRecords >= 1 ? Ok(personAddress) : Content("Error updating new address");
        }

        [HttpDelete]
        [Route("{personId}/{addressNo}")]
        public async Task<IActionResult> DeleteMenuItem([FromRoute] string personId, [FromRoute] int addressNo)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@PersonId", personId),
                new ProcedureParameter ("@AddressNo", addressNo)
            };

            int deletedRecords = await DbHelper.Instance.UpdateData("SSP_DeletePersonAddress", parameters);

            return deletedRecords >= 1 ? Ok() : this.Content("Error deleting person's address");
        }
    }
}
