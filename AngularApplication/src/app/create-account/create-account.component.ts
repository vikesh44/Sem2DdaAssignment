import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { AccountService } from './account.service';
import { SavePersonDetails } from './personDetail';
import { DatePipe } from '@angular/common';


@Component({
  selector: 'app-create-account',
  templateUrl: './create-account.component.html',
  styleUrls: ['./create-account.component.scss'],
})
export class CreateAccountComponent implements OnInit {
  createAccountForm!: FormGroup;
  buttonText: string = "Add";

  constructor(
    private formBuilder: FormBuilder,
    private accountService: AccountService,
    private accountDialog: MatDialogRef<CreateAccountComponent>,
    private datePipe: DatePipe,
    @Inject(MAT_DIALOG_DATA) public editData: any
  ) { }

  ngOnInit(): void {
    this.createAccountForm = this.formBuilder.group({
      personId: ['', ],
      userName: ['', [Validators.required]],
      password: ['', ],
      emailId: ['', Validators.required],
      dateOfBirth: ['', Validators.required],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      phoneNo: ['', Validators.required],
    });

    if (this.editData) {
      this.buttonText = "Update";
      this.createAccountForm.controls["userName"].setValue(this.editData.userName);
      this.createAccountForm.controls["password"].setValue(this.editData.password);
      this.createAccountForm.controls["emailId"].setValue(this.editData.emailId);
      this.createAccountForm.controls["dateOfBirth"].setValue(this.editData.dateOfBirth);
      this.createAccountForm.controls["firstName"].setValue(this.editData.firstName);
      this.createAccountForm.controls["lastName"].setValue(this.editData.lastName);
      this.createAccountForm.controls["phoneNo"].setValue(this.editData.phoneNo);
    }
  }

  addUpdateEmployee() {
    if (this.editData) {
      this.updateEmployee();
    } else {
      this.addNewEmployee();
    }
  }

  private addNewEmployee() {
    var modelData: SavePersonDetails = {
      personId: -1,
      userName: this.createAccountForm.value.userName,
      password: this.createAccountForm.value.password,
      emailId: this.createAccountForm.value.emailId,
      dateOfBirth: this.datePipe.transform(this.createAccountForm.value.dateOfBirth,"yyyy-MM-dd")?.toString(),
      firstName: this.createAccountForm.value.firstName,
      lastName: this.createAccountForm.value.lastName,
      phoneNo: this.createAccountForm.value.phoneNo,
      isCustomer: true
    };
    this.accountService.addPerson(modelData).subscribe({
      next: () => {
        this.createAccountForm.reset();
        this.accountDialog.close();
        alert('Model Added Successfully.');
      },
      error: () => {
        alert('Error while adding Model.');
      },
    });
    return modelData;
  }

  private updateEmployee() {
    var modelData: SavePersonDetails = {

      personId: this.editData.personId,
      userName: this.createAccountForm.value.userName,
      password: this.createAccountForm.value.password === undefined?'':this.createAccountForm.value.password,
      emailId: this.createAccountForm.value.emailId,
      dateOfBirth: this.datePipe.transform(this.createAccountForm.value.dateOfBirth,"yyyy-MM-dd")?.toString(),
      firstName: this.createAccountForm.value.firstName,
      lastName: this.createAccountForm.value.lastName,
      phoneNo: this.createAccountForm.value.phoneNo,
      isCustomer: true
    };
    this.accountService.updatePerson(this.editData.personId, modelData).subscribe({
      next: () => {
        this.createAccountForm.reset();
        this.accountDialog.close();
        alert('Model Updated Successfully.');
      },
      error: () => {
        alert('Error while Updating Model.');
      },
    });
  }
}
