export interface PersonOrder {
  orderId: string;
  customerId: string;
  customerName: string;
  employeeId: string;
  employeeName: string;
  tableId: number;
  orderType: string;
  cost: number;
  isCompleted: boolean;
  isReservation: boolean;
}

export interface Order {
  orderType: string;
  customerId: string;
  employeeId: string;
  tableId: number;
  isReservation: boolean;
}

export interface OrderItem {
  orderId: string;
  itemId: string;
  quantity: number;
}

export interface GetOrderItem {
  orderId: string;
  itemId: string;
  name: string;
  quantity: number;
  cost: number;
}

export interface OrderDialogData {
  orderId: string;
  orderItem?: OrderItem;
}

export interface BillItem {
  name: string;
  quantity: number;
  cost: number;
  amount: number;
}

export interface OrderBill {
  billItems: BillItem[];
  billPersonInfo: BillPersonInfo;
  orderId: string;
  billAmount: number;
}

export interface BillPersonInfo {
  customerName: string;
  employeeName: string;
  tableId: number;
}

export interface RestaurantDetail {
  fssaiNo: string;
  name: string;
  area: string;
  city: string;
  zip: string;
}

export interface ChefDisplay {
  itemId: string;
  name: string;
  quantity: number;
}
