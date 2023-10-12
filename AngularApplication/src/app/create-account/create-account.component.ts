import { Component, OnInit } from '@angular/core';
import { CreateAccountService } from './create-account.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Persondetail } from './personDetail';
import { Router } from '@angular/router';
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-create-account',
  templateUrl: './create-account.component.html',
  styleUrls: ['./create-account.component.scss'],
})
export class CreateAccountComponent implements OnInit {
  createAccountForm!: FormGroup;
  hide = true;

  constructor(
    private createAccountService: CreateAccountService,
    private formBuilder: FormBuilder,
    private router: Router,
    private datePipe: DatePipe
  ) {}

  ngOnInit(): void {
    this.createAccountForm = this.formBuilder.group({
      userName: ['', [Validators.required]],
      password: ['', Validators.required],
      emailId: ['', Validators.required],
      dateOfBirth: ['', Validators.required],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      phoneNo: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(10)]],
    });
  }

  createAccount() {
    var modelData: Persondetail = {
      userName: this.createAccountForm.value.userName,
      password: this.createAccountForm.value.password,
      emailId: this.createAccountForm.value.emailId,
      dateOfBirth: this.datePipe.transform(this.createAccountForm.value.dateOfBirth,"yyyy-MM-dd")?.toString(),
      firstName: this.createAccountForm.value.firstName,
      lastName: this.createAccountForm.value.lastName,
      phoneNo: this.createAccountForm.value.phoneNo,
    };

    this.createAccountService.addPerson(modelData).subscribe({
      next: () => {
        alert('Account Created Successfully. Please login using username and password.');
        this.router.navigate(['/menu']);
      },
      error: () => {
        alert('Error while creating user.');
      },
    });
  }
}
