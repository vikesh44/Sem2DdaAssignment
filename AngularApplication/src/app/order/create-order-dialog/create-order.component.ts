import { PersonAddressService } from './../../person-address/person-address.service';
import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { Order } from '../orderDto';
import { MatTableDataSource } from '@angular/material/table';
import { Persondetail } from 'src/app/create-account/personDetail';
import { AuthService } from 'src/app/shared/auth.service';
import { PersonAddress } from 'src/app/person-address/personAddress';

@Component({
  selector: 'app-create-order',
  templateUrl: './create-order.component.html',
  styleUrls: ['./create-order.component.scss'],
})
export class CreateOrderDialogComponent implements OnInit {
  createOrderDialogForm!: FormGroup;
  buttonText: string = 'Add';
  isEmployee!: boolean;
  orderType: string[] = ['Dine In', 'Drive thru', 'Online'];
  selectedOrderType: string = 'Dine In';

  employeesData: Persondetail[] = [];
  customerData: Persondetail[] = [];
  addresses: PersonAddress[] = [];

  constructor(
    private formBuilder: FormBuilder,
    private orderService: OrderService,
    private orderDialog: MatDialogRef<CreateOrderDialogComponent>,
    private authService: AuthService,
    private personAddressService: PersonAddressService,
  ) {}

  ngOnInit(): void {
    this.getAllEmployees();
    this.getAllCustomers();
    this.isEmployee = this.authService.IsEmployee();

    this.createOrderDialogForm = this.formBuilder.group({
      employeeId: [''],
      customerId: [''],
      tableId: ['', Validators.required],
      isReservation: [''],
      customerAddress: [''],
    });
  }

  getAllEmployees() {
    this.orderService.getEmployees().subscribe({
      next: (res: Persondetail[]) => {
        this.employeesData = res;
        if (this.isEmployee) {
          this.createOrderDialogForm.controls['employeeId'].setValue(
            Number(localStorage.getItem('personId'))
          );
        } else {
          this.createOrderDialogForm.controls['customerId'].setValue(
            Number(localStorage.getItem('personId'))
          );
        }
      },
      error: () => {
        alert('Error while reading Employees!');
      },
    });
  }

  getAllCustomers() {
    this.orderService.getCustomers().subscribe({
      next: (res: Persondetail[]) => {
        this.customerData = res;
      },
      error: () => {
        alert('Error while reading Employees!');
      },
    });
  }

  createOrder() {
    var orderData: Order = {
      employeeId: String(this.createOrderDialogForm.value.employeeId),
      customerId: String(this.createOrderDialogForm.value.customerId),
      tableId: Number(this.createOrderDialogForm.value.tableId),
      // orderType: this.createOrderDialogForm.value.orderType,
      orderType: this.selectedOrderType,
      isReservation: this.createOrderDialogForm.value.isReservation,
    };

    this.orderService.createOrder(orderData).subscribe({
      next: () => {
        this.createOrderDialogForm.reset();
        this.orderDialog.close();
        alert('Order Created Successfully.');
      },
      error: () => {
        alert('Error While Creating Order.');
      },
    });
    return orderData;
  }

  getAllPersonAddress() {
    this.personAddressService
      .getAllPersonAddress(String(this.createOrderDialogForm.value.customerId))
      .subscribe({
        next: (res: PersonAddress[]) => {
          this.addresses = res;
        },
        error: () => {
          alert('Error while reading your Address!');
        },
      });
  }
}
