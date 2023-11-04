export interface PersonAddress {
  personId: string;
  addressNo: number;
  houseNo: string;
  area: string;
  city: string;
  zip: string;
}

export interface PersonAddressDialog {
  addressNo: number;
  personAddress?: PersonAddress;
}
