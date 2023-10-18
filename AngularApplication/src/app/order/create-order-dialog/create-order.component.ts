import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { Order } from '../orderDto';
import { MatTableDataSource } from '@angular/material/table';
import { Persondetail } from 'src/app/create-account/personDetail';

@Component({
  selector: 'app-create-order',
  templateUrl: './create-order.component.html',
  styleUrls: ['./create-order.component.scss'],
})
export class CreateOrderDialogComponent implements OnInit {
  createOrderDialogForm!: FormGroup;
  buttonText: string = 'Add';

  constructor(
    private formBuilder: FormBuilder,
    private orderService: OrderService,
    private orderDialog: MatDialogRef<CreateOrderDialogComponent>
  ) {}

  ngOnInit(): void {
    this.getAllEmployees();
    this.getAllCustomers();

    this.createOrderDialogForm = this.formBuilder.group({
      employeeId: [''],
      customerId: [''],
      tableId: ['', Validators.required],
      orderType: ['', Validators.required],
      isReservation: [''],
    });
  }

  employeesData: Persondetail[] = [];
  customerData: Persondetail[] = [];
  orderType: string[] = ['Dine In', 'Online'];

  getAllEmployees() {
    this.orderService.getEmployees().subscribe({
      next: (res: Persondetail[]) => {
        this.employeesData = res;
        console.log(localStorage.getItem('personId'));
        this.createOrderDialogForm.controls['employeeId'].setValue(
          Number(localStorage.getItem('personId'))
        );
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
      orderType: this.createOrderDialogForm.value.orderType,
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
}
