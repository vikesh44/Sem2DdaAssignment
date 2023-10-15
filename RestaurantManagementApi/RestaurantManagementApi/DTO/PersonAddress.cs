namespace RestaurantManagementApi.DTO
{
    public class PersonAddress
    {
        public PersonAddress()
        {
            
        }
        public long PersonId { get; set; }
        public int AddressNo { get; set; }
        public string HouseNo { get; set; }
        public string Area { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
    }
}
