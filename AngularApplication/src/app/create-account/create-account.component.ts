import { Component, OnInit, Inject } from '@angular/core';
import { AccountService } from './account.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Persondetail, SavePersonDetails } from './personDetail';
import { Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-create-account',
  templateUrl: './create-account.component.html',
  styleUrls: ['./create-account.component.scss'],
})
export class CreateAccountComponent implements OnInit {
  createAccountForm!: FormGroup;
  hide = true;
  buttonText: string = "Create Account";
  headerText: string = "Register";

  constructor(
    private createAccountService: AccountService,
    private formBuilder: FormBuilder,
    private router: Router,
    private datePipe: DatePipe,
    @Inject(MAT_DIALOG_DATA) public editData: any
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

    if (this.editData) {
      this.buttonText = "Update";
      this.headerText = "Update Details";
      this.createAccountForm.controls["personId"].setValue(this.editData.personId);
      this.createAccountForm.controls["userName"].setValue(this.editData.userName);
      this.createAccountForm.controls["password"].setValue(this.editData.password);
      this.createAccountForm.controls["emailId"].setValue(this.editData.emailId);
      this.createAccountForm.controls["dateOfBirth"].setValue(this.editData.dateOfBirth);
      this.createAccountForm.controls["firstName"].setValue(this.editData.firstName);
      this.createAccountForm.controls["lastName"].setValue(this.editData.lastName);
      this.createAccountForm.controls["phoneNo"].setValue(this.editData.phoneNo);
    }
  }

  createAccount() {
    var personData: SavePersonDetails = {
      personId: this.createAccountForm.value.personId,
      userName: this.createAccountForm.value.userName,
      password: this.createAccountForm.value.password,
      emailId: this.createAccountForm.value.emailId,
      dateOfBirth: this.datePipe.transform(this.createAccountForm.value.dateOfBirth,"yyyy-MM-dd")?.toString(),
      firstName: this.createAccountForm.value.firstName,
      lastName: this.createAccountForm.value.lastName,
      phoneNo: this.createAccountForm.value.phoneNo,
      isCustomer: true
    };

    this.createAccountService.addPerson(personData).subscribe({
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
