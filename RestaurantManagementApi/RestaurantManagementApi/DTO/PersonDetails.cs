﻿namespace RestaurantManagementApi.DTO
{
    public class PersonDetails
    {
        public PersonDetails()
        {
            //Empty default constructor
        }

        public long PersonId { get; set; }
        public string UserName { get; set; }
        public string EmailId { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNo { get; set; }
    }

    public class SavePersonDetails : PersonDetails
    {
        public SavePersonDetails()
        {
            //Empty default constructor
        }

        public string Password { get; set; }
        public bool IsCustomer { get; set; }
    }

    public class PersonLoginDetail
    {
        public PersonLoginDetail()
        {
            
        }

        public long PersonId { get; set; }
        public string FirstName { get; set; }
        public bool IsCustomer { get; set; }
    }
}
