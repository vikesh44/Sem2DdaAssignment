import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ApiPaths, environment } from 'src/environments/environment';
import { MenuItem, UpdateMenuItem } from './menuItem';

@Injectable({
  providedIn: 'root',
})
export class MenuService {
  private headers = { 'content-type': 'application/json' };

  constructor(private http: HttpClient) {}

  getAllMenus(): any {
    return this.http.get<any>(environment.baseUrl + ApiPaths.Menu);
  }

  addMenuItem(newMenuItem: MenuItem): any {
    return this.http.post(
      environment.baseUrl + ApiPaths.Menu,
      JSON.stringify(newMenuItem),
      { headers: this.headers }
    );
  }

  updateMenuItem(itemId: string, menuItem: UpdateMenuItem): any {
    return this.http.put(
      environment.baseUrl + ApiPaths.Menu + '/' + itemId,
      JSON.stringify(menuItem),
      { headers: this.headers }
    );
  }

  deleteMenuItem(itemId: string): any {
    return this.http.delete(environment.baseUrl + ApiPaths.Menu + '/' + itemId);
  }
}
