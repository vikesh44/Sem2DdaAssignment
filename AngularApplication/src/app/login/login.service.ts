import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';
import { ApiPaths } from 'src/environments/environment';
import { LoginResponse } from './LoginResponse';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor(private http: HttpClient, private router: Router) { }

  loginUser(userName: string, password: string) {
    alert(environment.baseUrl + ApiPaths.Login + '?userName='+userName+'&password='+password);
    const headers = { 'content-type': 'application/json' };
    return this.http.post<LoginResponse>(environment.baseUrl + ApiPaths.Login + '?userName='+userName+'&password='+password, { headers: headers })
      .subscribe({
        next: (result: any) => {
          localStorage.setItem("token", result.accessToken);
          localStorage.setItem("currentUser", result.name);
          alert("Login Success!");
        },
        error: (err: any) => {
          alert("Login failed. Please enter valid credentials or try again after some time.");
        }
      });
  }
}
