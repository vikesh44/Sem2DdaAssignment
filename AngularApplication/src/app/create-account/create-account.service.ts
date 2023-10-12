import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, PersondetailPaths, environment } from 'src/environments/environment';
import { Persondetail } from './personDetail';

@Injectable({
  providedIn: 'root',
})

export class CeateAccountService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) { }

  addPerson(persondetail: Persondetail): any {
    return this.http.post(environment.baseUrl + ApiPaths.Customer, JSON.stringify(persondetail), { headers: this.headers });

    // return this.http.post(environment.baseUrl + ApiPaths.Customer +
    //   PersondetailPaths.UserName + persondetail.userName +
    //   PersondetailPaths.Password + persondetail.password +
    //   PersondetailPaths.EmailId + persondetail.emailId +
    //   PersondetailPaths.DateOfBirth + persondetail.dateOfBirth +
    //   PersondetailPaths.FirstName + persondetail.firstName +
    //   PersondetailPaths.LastName + persondetail.lastName +
    //   PersondetailPaths.PhoneNo + persondetail.phoneNo
    //   , { headers: this.headers });
  }
}
