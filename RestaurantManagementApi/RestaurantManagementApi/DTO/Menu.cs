namespace RestaurantManagementApi.DTO
{
    public class Menu
    {
        public Menu()
        {
            
        }

        public Menu(string itemId, string category, string name, decimal cost)
        {
            ItemId = itemId;
            Category = category;
            Name = name;
            Cost = cost;
        }

        public string ItemId { get; set; }
        public string Category { get; set; }
        public string Name { get; set; }
        public decimal Cost { get; set; }
    }
}
