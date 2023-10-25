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
    public class OrderController : Controller
    {
        #region Order Methods

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

            return updatedRecords >= 1 ? Ok(order) : Content("Error creating new Order");
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

        #endregion

        #region OrderItems Methods

        [HttpGet]
        [Route("{orderId}")]
        public async Task<IActionResult> GetOrderItems([FromRoute] string orderId)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@OrderId", orderId)
            };

            return Ok(await DbHelper.Instance.GetData<OrderItem>("SSP_GetOrderItems", parameters));
        }

        [HttpPost]
        [Route("AddOrderItems")]
        public async Task<IActionResult> AddOrderItems(OrderItem orderItems)
        {
            DataTable dataTable = GetOrderItemDataTable();

            dataTable.Rows.Add(CreateDataRow(dataTable.NewRow(), orderItems));

            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@OrderItems", dataTable)
            };

            int updatedRecords = await DbHelper.Instance.UpdateData("SSP_AddUpdateOrderItems", parameters);

            return updatedRecords >= 1 ? Ok(updatedRecords) : Content("Error adding items");
        }

        [HttpPut]
        [Route("UpdateQuantity")]
        public async Task<IActionResult> UpdateQuantity(OrderItem orderItem)
        {
            DataTable dataTable = GetOrderItemDataTable();

            dataTable.Rows.Add(CreateDataRow(dataTable.NewRow(), orderItem));

            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@OrderItems", dataTable)
            };

            int updatedRecords = await DbHelper.Instance.UpdateData("SSP_AddUpdateOrderItems", parameters);

            return updatedRecords >= 1 ? Ok(updatedRecords) : Content("Error updating quantity");
        }

        [HttpDelete]
        [Route("{orderId}/{itemId}")]
        public async Task<IActionResult> DeleteOrderItem([FromRoute] string orderId, [FromRoute] string itemId)
        {
            List<ProcedureParameter> parameters = new()
            {
                new ProcedureParameter ("@OrderId", orderId),
                new ProcedureParameter ("@ItemId", itemId),
            };

            int deletedRecords = await DbHelper.Instance.UpdateData("SSP_DeleteOrderItem", parameters);

            return deletedRecords >= 1 ? Ok() : this.Content("Error deleting order item");
        }

        private static DataTable GetOrderItemDataTable()
        {
            DataTable dataTable = new();
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "OrderId"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_STRING), "ItemId"));
            dataTable.Columns.Add(CreateDataColumn(Type.GetType(Constants.TYPE_INT32), "Quantity"));
            return dataTable;
        }

        private static DataRow CreateDataRow(DataRow dtRow, OrderItem data)
        {
            dtRow["OrderId"] = data.OrderId;
            dtRow["ItemId"] = data.ItemId;
            dtRow["Quantity"] = data.Quantity;
            return dtRow;
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

        #endregion
    }
}
