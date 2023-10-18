import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { Order } from '../orderDto';

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
    this.createOrderDialogForm = this.formBuilder.group({
      employeeId: ['', [Validators.required]],
      customerId: ['', Validators.required],
      tableId: ['', Validators.required],
      orderType: ['', Validators.required],
      isReservation: [''],
    });
  }

  createOrder() {
    var orderData: Order = {
      employeeId: this.createOrderDialogForm.value.employeeId,
      customerId: this.createOrderDialogForm.value.customerId,
      tableId: this.createOrderDialogForm.value.tableId,
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
