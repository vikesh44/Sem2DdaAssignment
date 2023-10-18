import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, environment } from 'src/environments/environment';
import { Persondetail, SavePersonDetails } from './personDetail';

@Injectable({
  providedIn: 'root',
})
export class AccountService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) {}

  getEmployees(): any {
    return this.http.get<any>(environment.baseUrl + ApiPaths.Person + ApiPaths.GetEmployees);
  }

  addPerson(persondetail: SavePersonDetails): any {
    return this.http.post(
      environment.baseUrl + ApiPaths.CreateAccount,
      JSON.stringify(persondetail),
      { headers: this.headers }
    );
  }

  updatePerson(itemId: string, menuItem: SavePersonDetails): any {
    return this.http.put(environment.baseUrl + ApiPaths.Person + '/' + itemId, JSON.stringify(menuItem), { headers: this.headers });
  }

  deletePerson(personId: string, isCustomer: boolean): any {
    return this.http.delete(environment.baseUrl + ApiPaths.Person + "/" + personId + "/" + isCustomer);
  }
}
