import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, environment } from 'src/environments/environment';
import { PersonAddress } from './personAddress';

@Injectable({
  providedIn: 'root',
})
export class PersonAddressService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) {
  }

  getAllPersonAddress(personId: string|null): any {
    return this.http.get<any>(environment.baseUrl + ApiPaths.PersonAddress + '/' + personId);
  }

  addPersonAddress(newPersonAddress: PersonAddress): any {
    return this.http.post(environment.baseUrl + ApiPaths.PersonAddress, JSON.stringify(newPersonAddress), { headers: this.headers });
  }

  updatePersonAddress(personAddress: PersonAddress): any {
    return this.http.put(environment.baseUrl + ApiPaths.PersonAddress + '/' + personAddress.personId, JSON.stringify(personAddress), { headers: this.headers });
  }

  deletePersonAddress(personId: string|null, addressNo: string): any {
    return this.http.delete(environment.baseUrl + ApiPaths.PersonAddress + "/" + personId + "/" + addressNo);
  }
}
