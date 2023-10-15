export interface Persondetail {
  personId: string;
  userName: string;
  emailId: string;
  dateOfBirth?: string;
  firstName: string;
  lastName: string;
  phoneNo: string;
}

export interface SavePersonDetails {
  personId: string;
  userName: string;
  password: string;
  emailId: string;
  dateOfBirth?: string;
  firstName: string;
  lastName: string;
  phoneNo: string;
  isCustomer: boolean;
}
