// This file can be replaced during build by using the `fileReplacements` array.
// `ng build` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  baseUrl: 'http://localhost:5224/api'
};

export enum ApiPaths {
  Login = '/Login/ValidateUser',
  ForgotPassword = '/Login/ForgotPassword',
  Menu = '/Menu',
  Person = '/Person',
  CreateAccount = '/Person/CreatePersonAccount',
  PersonAddress='/PersonAddress',
  Order='/Order',
  GetEmployees='/GetEmployees',
  GetCustomers='/GetCustomers',
}

export enum PersondetailPaths {
  UserName = 'UserName=',
  Password = 'Password=',
  EmailId = 'EmailId=',
  DateOfBirth = 'DateOfBirth=',
  FirstName = 'FirstName=',
  LastName = 'LastName=',
  PhoneNo = 'PhoneNo='
}

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/plugins/zone-error';  // Included with Angular CLI.
