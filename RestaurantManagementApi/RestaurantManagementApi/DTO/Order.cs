﻿namespace RestaurantManagementApi.DTO
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
        public string CustomerName { get; set; }
        public string EmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public int TableId { get; set; }
        public string OrderType { get; set; }
        public decimal Cost { get; set; }
        public bool IsReservation { get; set; }
        public bool IsCompleted { get; set; }
    }

    public class OrderItem
    {
        public string OrderId { get; set; }
        public string ItemId { get; set; }
        public int Quantity { get; set; }
    }

    public class GetOrderItem : OrderItem
    {
        public string Name { get; set; }
        public decimal Cost { get; set; }
    }
}
