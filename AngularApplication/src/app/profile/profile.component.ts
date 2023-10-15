import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import { ProfileService } from './profile.service';
import { Persondetail } from '../create-account/personDetail';

@Component({
  selector: 'app-update-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  updateProfileForm!: FormGroup;
  hide = true;

  constructor(
    private profileService: ProfileService,
    private formBuilder: FormBuilder,
    private datePipe: DatePipe
  ) {}

  ngOnInit(): void {
    this.updateProfileForm = this.formBuilder.group({
      userName: ['', [Validators.required]],
      password: ['', Validators.required],
      emailId: ['', Validators.required],
      dateOfBirth: ['', Validators.required],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      phoneNo: [
        '',
        [
          Validators.required,
          Validators.minLength(10),
          Validators.maxLength(10),
        ],
      ],
    });

    this.profileService.getPersonDetail().subscribe({
      next: (res: Persondetail[]) => {
        this.updateProfileForm.controls['personId'].setValue(res[0].personId);
        this.updateProfileForm.controls['userName'].setValue(res[0].userName);
        this.updateProfileForm.controls['emailId'].setValue(res[0].emailId);
        this.updateProfileForm.controls['dateOfBirth'].setValue(res[0].dateOfBirth);
        this.updateProfileForm.controls['firstName'].setValue(res[0].firstName);
        this.updateProfileForm.controls['lastName'].setValue(res[0].lastName);
        this.updateProfileForm.controls['phoneNo'].setValue(res[0].phoneNo);
      },
      error: () => {
        alert('Error while reading user details!');
      },
    });
  }

  createAccount() {
    var modelData: Persondetail = {
      personId: this.updateProfileForm.value.personId,
      userName: this.updateProfileForm.value.userName,
      emailId: this.updateProfileForm.value.emailId,
      dateOfBirth: this.datePipe
        .transform(this.updateProfileForm.value.dateOfBirth, 'yyyy-MM-dd')
        ?.toString(),
      firstName: this.updateProfileForm.value.firstName,
      lastName: this.updateProfileForm.value.lastName,
      phoneNo: this.updateProfileForm.value.phoneNo,
    };

    this.profileService.updatePerson(modelData).subscribe({
      next: () => {
        alert('Account Updated Successfully.');
      },
      error: () => {
        alert('Error while creating user.');
      },
    });
  }
}
