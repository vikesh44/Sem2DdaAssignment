import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Subject } from 'rxjs';
import { AuthService } from '../shared/auth.service';

@Component({
  selector: 'app-template',
  templateUrl: './template.component.html',
  styleUrls: ['./template.component.scss'],
})
export class TemplateComponent implements OnInit {
  userActivity: any;
  userInactive: Subject<any> = new Subject();
  isEmployee!: boolean;

  name!: string;
  constructor(private router: Router, private authService: AuthService) {
    this.userInactive.subscribe(() => this.logout());
  }

  ngOnInit(): void {
    const userJson = localStorage.getItem('currentUser');
    this.name = userJson !== null ? `Hello ${userJson} ` : '';
    this.autoLogout(120000);
    this.isEmployee = this.authService.IsEmployee();
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
