import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { OrderDialogData, OrderItem } from '../orderDto';
import { MenuItem } from 'src/app/menu/menuItem';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-order-item-dialog',
  templateUrl: './order-item-dialog.component.html',
  styleUrls: ['./order-item-dialog.component.scss'],
})
export class OrderItemDialogComponent implements OnInit {
  orderItemDialogForm!: FormGroup;
  buttonText: string = 'Add';
  orderId!: string;
  menuItems: MenuItem[] = [];

  constructor(
    private formBuilder: FormBuilder,
    private orderService: OrderService,
    private orderItemDialog: MatDialogRef<OrderItemDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public editData: OrderDialogData,
    private activatedRoute: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.orderItemDialogForm = this.formBuilder.group({
      orderId: ['', [Validators.required]],
      itemId: ['', [Validators.required]],
      quantity: ['', Validators.required],
    });

    this.activatedRoute.paramMap.subscribe((params) => {
      this.orderId = String(params.get('orderId'));
    });
    this.getAllMenuItems();
    this.orderItemDialogForm.controls['orderId'].setValue(this.editData.orderId);

    if (this.editData.orderItem) {
      this.buttonText = 'Update';

      this.orderItemDialogForm.controls['itemId'].setValue(
        this.editData.orderItem.itemId
      );
      this.orderItemDialogForm.controls['quantity'].setValue(
        this.editData.orderItem.quantity
      );
    }
  }

  addUpdateOrderItem() {
    var modelData: OrderItem = {
      orderId: this.orderItemDialogForm.value.orderId,
      itemId: this.orderItemDialogForm.value.itemId,
      quantity: this.orderItemDialogForm.value.quantity,
    };

    if (this.editData.orderItem) {
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

  getAllMenuItems() {
    this.orderService.getMenuItems().subscribe({
      next: (res: MenuItem[]) => {
        this.menuItems = res;
      },
      error: () => {
        alert('Error while reading Menu Items!');
      },
    });
  }
}
