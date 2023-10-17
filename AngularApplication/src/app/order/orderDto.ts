import { Time } from '@angular/common';

export interface PersonOrder {
  orderId: string;
  customerId: string;
  employeeId: string;
  tableId: string;
  orderType: string;
  cost: number;
  isCompleted: boolean;
  isReservation: boolean;
}

export interface Order {
  orderType: string;
  customerId: string;
  employeeId: string;
  tableId: string;
  isReservation: boolean;
}
