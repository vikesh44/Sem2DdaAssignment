namespace RestaurantManagementApi.DTO
{
    public class UpdateMenu
    {
        public UpdateMenu()
        {

        }

        public string Category { get; set; }
        public string Name { get; set; }
        public decimal Cost { get; set; }
    }

    public class Menu : UpdateMenu
    {
        public Menu()
        {

        }

        public string ItemId { get; set; }
    }
}
