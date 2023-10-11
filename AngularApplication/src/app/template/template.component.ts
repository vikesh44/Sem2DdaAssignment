import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subject } from 'rxjs';

@Component({
  selector: 'app-template',
  templateUrl: './template.component.html',
  styleUrls: ['./template.component.scss'],
})
export class TemplateComponent implements OnInit {
  userActivity: any;
  userInactive: Subject<any> = new Subject();

  name!: string;
  constructor(private router: Router) {
    this.userInactive.subscribe(() => this.logout());
  }

  ngOnInit(): void {
    const userJson = localStorage.getItem('currentUser');
    this.name = userJson !== null ? `Hello ${userJson} ` : '';
    this.autoLogout(120000);
  }

  autoLogout(expirationTime: number): void {
    this.userActivity = setTimeout(
      () => this.userInactive.next(undefined),
      expirationTime
    );
  }

  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('currentUser');
    this.router.navigate(['/login']);
  }
}
