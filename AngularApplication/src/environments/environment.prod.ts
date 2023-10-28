export const environment = {
  production: true,
  baseUrl: 'http://localhost:5224/api',
};

export enum ApiPaths {
  Login = '/Login/ValidateUser',
  ForgotPassword = '/Login/ForgotPassword',
  Menu = '/Menu',
  Person = '/Person',
  CreateAccount = '/Person/CreatePersonAccount',
  PersonAddress = '/PersonAddress',
  Order = '/Order',
  AddOrderItems = '/Order/AddOrderItems',
  UpdateQuantity = '/Order/UpdateQuantity',
  GetEmployees = '/GetEmployees',
  GetCustomers = '/GetCustomers',
}

export enum PersondetailPaths {
  UserName = 'UserName=',
  Password = 'Password=',
  EmailId = 'EmailId=',
  DateOfBirth = 'DateOfBirth=',
  FirstName = 'FirstName=',
  LastName = 'LastName=',
  PhoneNo = 'PhoneNo=',
}
