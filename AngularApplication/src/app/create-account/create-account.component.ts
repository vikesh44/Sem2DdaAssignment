import { Component, OnInit } from '@angular/core';
import { CeateAccountService } from './create-account.service';
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
  createAcccountForm!: FormGroup;
  hide = true;

  constructor(
    private createAcountService: CeateAccountService,
    private formBuilder: FormBuilder,
    private router: Router,
    private datePipe: DatePipe
  ) {}

  ngOnInit(): void {
    this.createAcccountForm = this.formBuilder.group({
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
      userName: this.createAcccountForm.value.userName,
      password: this.createAcccountForm.value.password,
      emailId: this.createAcccountForm.value.emailId,
      dateOfBirth: this.datePipe.transform(this.createAcccountForm.value.dateOfBirth,"yyyy-MM-dd")?.toString(),
      firstName: this.createAcccountForm.value.firstName,
      lastName: this.createAcccountForm.value.lastName,
      phoneNo: this.createAcccountForm.value.phoneNo,
    };

    this.createAcountService.addPerson(modelData).subscribe({
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
