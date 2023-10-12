import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, environment } from 'src/environments/environment';
import { Persondetail } from './personDetail';

@Injectable({
  providedIn: 'root',
})
export class CreateAccountService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) {}

  addPerson(persondetail: Persondetail): any {
    return this.http.post(
      environment.baseUrl + ApiPaths.Person,
      JSON.stringify(persondetail),
      { headers: this.headers }
    );
  }
}
