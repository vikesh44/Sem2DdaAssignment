import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor() { }

  IsLoggedIn() {
    return !!localStorage.getItem('token');
  }

  IsEmployee() {
    return this.IsLoggedIn() && localStorage.getItem('isCustomer') === 'false';
  }
}
