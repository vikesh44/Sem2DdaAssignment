import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class MenuService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) {}

  getAllMenus(): any {
    return this.http.get<any>(environment.baseUrl + ApiPaths.Menu);
  }

//   deleteMenu(modelNumber: string): any {
//     return this.http.delete(
//       environment.baseUrl + ApiPaths.Models + '/' + modelNumber
//     );
//   }

//   addModel(modelDTO: NewModelDTO): any {
//     return this.http.post(
//       environment.baseUrl + ApiPaths.Models,
//       JSON.stringify(modelDTO),
//       { headers: this.headers }
//     );
//   }
}
