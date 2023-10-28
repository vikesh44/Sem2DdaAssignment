import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, Constants, environment } from 'src/environments/environment';
import { Order, OrderItem } from './orderDto';

@Injectable({
  providedIn: 'root',
})
export class OrderService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) {}

  getAllOrders(isCompleted: boolean): any {
    var personId = localStorage.getItem('personId');
    var isCustomer = localStorage.getItem('isCustomer');
    return this.http.get<any>(
      environment.baseUrl +
        ApiPaths.Order +
        '/' +
        personId +
        '/' +
        isCustomer +
        '/' +
        isCompleted
    );
  }

  createOrder(order: Order): any {
    return this.http.post(
      environment.baseUrl + ApiPaths.Order,
      JSON.stringify(order),
      { headers: this.headers }
    );
  }

  getOrderItems(orderId: string): any {
    return this.http.get<any>(
      environment.baseUrl + ApiPaths.Order + '/' + orderId
    );
  }

  addOrderItem(orderItems: OrderItem): any {
    return this.http.post(
      environment.baseUrl + ApiPaths.AddOrderItems,
      JSON.stringify(orderItems),
      { headers: this.headers }
    );
  }

  updateOrderQuantity(orderItem: OrderItem): any {
    return this.http.put(
      environment.baseUrl + ApiPaths.UpdateQuantity,
      JSON.stringify(orderItem),
      { headers: this.headers }
    );
  }

  deleteOrderItem(orderId: string, itemId: string): any {
    return this.http.delete(
      environment.baseUrl + ApiPaths.Order + '/' + orderId + '/' + itemId
    );
  }

  getEmployees(): any {
    return this.http.get<any>(
      environment.baseUrl + ApiPaths.Person + ApiPaths.GetEmployees
    );
  }

  getCustomers(): any {
    return this.http.get<any>(
      environment.baseUrl + ApiPaths.Person + ApiPaths.GetCustomers
    );
  }

  getMenuItems(): any {
    return this.http.get<any>(environment.baseUrl + ApiPaths.Menu);
  }

  getRestaurantDetail(): any {
    return this.http.get<any>(
      environment.baseUrl + ApiPaths.GetRestaurantDetail + Constants.FssaiNumber
    );
  }

  getChefDisplay(): any {
    return this.http.get<any>(
      environment.baseUrl + ApiPaths.GetChefDisplayItems
    );
  }

  completeOrder(orderId: string): any {
    return this.http.put(
      environment.baseUrl + ApiPaths.CompleteOrder + '/' + orderId,
      { headers: this.headers }
    );
  }
}
