import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { PersonAddressService } from '../person-address.service';
import { PersonAddress } from '../personAddress';


@Component({
  selector: 'app-address-dialog',
  templateUrl: './address-dialog.component.html',
  styleUrls: ['./address-dialog.component.scss'],
})
export class AddressDialogComponent implements OnInit {
  addressDialogForm!: FormGroup;
  buttonText: string = "Add";

  constructor(
    private formBuilder: FormBuilder,
    private addressService: PersonAddressService,
    private addressDialog: MatDialogRef<AddressDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public editData: any
  ) { }

  ngOnInit(): void {
    this.addressDialogForm = this.formBuilder.group({
      addressNo: ['', Validators.required],
      houseNo: ['', Validators.required],
      area: ['', Validators.required],
      city: ['', Validators.required],
      zip: ['', Validators.required],
    });

    if (this.editData) {
      this.buttonText = "Update";
      this.addressDialogForm.controls["addressNo"].setValue(this.editData.addressNo);
      this.addressDialogForm.controls["houseNo"].setValue(this.editData.houseNo);
      this.addressDialogForm.controls["area"].setValue(this.editData.area);
      this.addressDialogForm.controls["city"].setValue(this.editData.city);
      this.addressDialogForm.controls["zip"].setValue(this.editData.zip);
    }
  }

  addUpdateAddress() {
    if (this.editData) {
      this.updateAddress();
    } else {
      this.addNewAddress();
    }
  }

  private addNewAddress() {
    var modelData: PersonAddress = {
      personId: String(localStorage.getItem('personId')),
      addressNo: this.addressDialogForm.value.addressNo,
      houseNo: this.addressDialogForm.value.houseNo,
      area: this.addressDialogForm.value.area,
      city: this.addressDialogForm.value.city,
      zip: this.addressDialogForm.value.zip,
    };
    this.addressService.addPersonAddress(modelData).subscribe({
      next: () => {
        this.addressDialogForm.reset();
        this.addressDialog.close();
        alert('Address Added Successfully.');
      },
      error: () => {
        alert('Error while adding Address.');
      },
    });
    return modelData;
  }

  private updateAddress() {
    var modelData: PersonAddress = {
      personId: String(localStorage.getItem('personId')),
      addressNo: this.addressDialogForm.value.addressNo,
      houseNo: this.addressDialogForm.value.houseNo,
      area: this.addressDialogForm.value.area,
      city: this.addressDialogForm.value.city,
      zip: this.addressDialogForm.value.zip,
    };
    this.addressService.updatePersonAddress(modelData).subscribe({
      next: () => {
        this.addressDialogForm.reset();
        this.addressDialog.close();
        alert('Address Updated Successfully.');
      },
      error: () => {
        alert('Error while Updating Address.');
      },
    });
  }
}
