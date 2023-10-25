import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { OrderItem } from '../orderDto';

@Component({
  selector: 'app-order-item-dialog',
  templateUrl: './order-item-dialog.component.html',
  styleUrls: ['./order-item-dialog.component.scss'],
})
export class OrderItemDialogComponent implements OnInit {
  orderItemDialogForm!: FormGroup;
  buttonText: string = 'Add';

  constructor(
    private formBuilder: FormBuilder,
    private orderService: OrderService,
    private orderItemDialog: MatDialogRef<OrderItemDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public editData: any
  ) {}

  ngOnInit(): void {
    this.orderItemDialogForm = this.formBuilder.group({
      orderId: ['', [Validators.required]],
      itemId: ['', [Validators.required]],
      quantity: ['', Validators.required],
    });

    if (this.editData) {
      this.buttonText = 'Update';
      this.orderItemDialogForm.controls['orderId'].setValue(
        this.editData.orderId
      );
      this.orderItemDialogForm.controls['itemId'].setValue(
        this.editData.itemId
      );
      this.orderItemDialogForm.controls['quantity'].setValue(
        this.editData.quantity
      );
    }
  }

  addUpdateOrderItem() {
    var modelData: OrderItem = {
      orderId: this.orderItemDialogForm.value.orderId,
      itemId: this.orderItemDialogForm.value.itemId,
      quantity: this.orderItemDialogForm.value.quantity,
    };

    if (this.editData) {
      this.orderService.updateOrderQuantity(modelData).subscribe({
        next: () => {
          this.orderItemDialogForm.reset();
          this.orderItemDialog.close();
        },
        error: () => {
          alert('Error while adding item.');
        },
      });
    } else {
      this.orderService.addOrderItem(modelData).subscribe({
        next: () => {
          this.orderItemDialogForm.reset();
          this.orderItemDialog.close();
        },
        error: () => {
          alert('Error while updating quantity.');
        },
      });
    }
    return modelData;
  }
}
