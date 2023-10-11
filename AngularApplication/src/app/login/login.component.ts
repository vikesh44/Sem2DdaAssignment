import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LoginService } from './login.service';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  userName = "";
  password = "";
  tokenValue = "";
  hide = true;

  constructor(private loginService: LoginService, private fb: FormBuilder) {
  }

  ngOnInit(): void {
  }

  loginForm: FormGroup = this.fb.group({
    email: ['', [Validators.required]],
    password: ['', [Validators.required]]
  })

  login() {
    if (!this.loginForm.valid) {
      return;
    }
    this.loginService.loginUser(this.userName, this.password);
  }
}
