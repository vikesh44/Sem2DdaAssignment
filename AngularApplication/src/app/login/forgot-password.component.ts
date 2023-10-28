import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { LoginService } from './login.service';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./login.component.scss'],
})
export class ForgotPasswordComponent implements OnInit {
  email = '';
  emailPattern = /\S+@\S+\.\S+/;

  constructor(private loginService: LoginService, private fb: FormBuilder) {}

  ngOnInit(): void {}

  forgotPasswordForm: FormGroup = this.fb.group({
    email: ['', [Validators.required, Validators.pattern(this.emailPattern)]],
  });

  forgotPassword() {
    if (!this.forgotPasswordForm.valid) {
      return;
    }
    this.loginService.forgotPassword(this.email);
  }
}
