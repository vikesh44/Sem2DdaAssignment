export interface Persondetail {
  personId: number;
  userName: string;
  emailId: string;
  dateOfBirth?: string;
  firstName: string;
  lastName: string;
  phoneNo: string;
}

export interface SavePersonDetails {
  personId: number;
  userName: string;
  password: string;
  emailId: string;
  dateOfBirth?: string;
  firstName: string;
  lastName: string;
  phoneNo: string;
  isCustomer: boolean;
}
