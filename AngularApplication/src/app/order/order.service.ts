import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, environment } from 'src/environments/environment';
import { Order } from './orderDto';

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
}
