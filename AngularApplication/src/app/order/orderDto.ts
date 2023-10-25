import { Time } from '@angular/common';

export interface PersonOrder {
  orderId: string;
  customerId: string;
  employeeId: string;
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

export interface OrderDialogData {
  orderId: string;
  orderItem?: OrderItem;
}
