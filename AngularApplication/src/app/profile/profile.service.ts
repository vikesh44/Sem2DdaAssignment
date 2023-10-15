import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, environment } from 'src/environments/environment';
import { Persondetail, SavePersonDetails } from '../create-account/personDetail';

@Injectable({
  providedIn: 'root',
})
export class ProfileService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) {}

  getPersonDetail(): any {
    var personId = localStorage.getItem('personId');
    return this.http.get<Persondetail>(environment.baseUrl + ApiPaths.Person + '/' + personId);
  }

  updatePerson(persondetail: SavePersonDetails): any {
    var personId = localStorage.getItem('personId');

    return this.http.put(
      environment.baseUrl + ApiPaths.Person + '/' + personId,
      JSON.stringify(persondetail),
      { headers: this.headers }
    );
  }
}
