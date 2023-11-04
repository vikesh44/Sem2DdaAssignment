import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LoginService } from './login.service';
import { MatDialog } from '@angular/material/dialog';
import { CreateAccountComponent } from '../create-account/create-account.component';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent implements OnInit {
  userName = '';
  password = '';
  tokenValue = '';
  hide = true;

  constructor(
    private loginService: LoginService,
    private fb: FormBuilder,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {}

  loginForm: FormGroup = this.fb.group({
    email: ['', [Validators.required]],
    password: ['', [Validators.required]],
  });

  login() {
    if (!this.loginForm.valid) {
      return;
    }
    this.loginService.loginUser(this.userName, this.password);
  }

  createAccount() {
    const dialogRef = this.dialog.open(CreateAccountComponent, {
      width: '25%',
    });
  }
}
