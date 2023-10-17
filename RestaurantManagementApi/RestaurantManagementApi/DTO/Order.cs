namespace RestaurantManagementApi.DTO
{
    public class Order
    {
        public string OrderType { get; set; }
        public string CustomerId { get; set; }
        public string EmployeeId { get; set; }
        public int TableId { get; set; }
        public bool IsReservation { get; set; }

    }

    public class PersonOrders
    {
        public string OrderId { get; set; }
        public string CustomerId { get; set; }
        public string EmployeeId { get; set; }
        public int TableId { get; set; }
        public string OrderType { get; set; }
        public decimal Cost { get; set; }
        public bool IsReservation { get; set; }
        public bool IsCompleted { get; set; }
    }
}
