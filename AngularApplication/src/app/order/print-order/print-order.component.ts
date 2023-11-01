import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { BillItem, OrderBill, RestaurantDetail } from '../orderDto';
import { MenuItem } from 'src/app/menu/menuItem';
import { MatTableDataSource } from '@angular/material/table';
import { Constants } from 'src/environments/environment';
import { Router } from '@angular/router';

@Component({
  selector: 'app-print-order',
  templateUrl: './print-order.component.html',
  styleUrls: ['./print-order.component.scss'],
})
export class PrintOrderDialogComponent implements OnInit {
  orderItemDialogForm!: FormGroup;
  menuItems: MenuItem[] = [];
  restaurantDetails: RestaurantDetail = {
    fssaiNo: Constants.FssaiNumber,
    name: '',
    area: '',
    city: '',
    zip: '',
  };
  dataSource!: MatTableDataSource<BillItem>;

  displayedColumns: string[] = ['Name', 'Quantity', 'Cost', 'Amount'];

  constructor(
    private formBuilder: FormBuilder,
    private orderService: OrderService,
    private orderItemDialog: MatDialogRef<PrintOrderDialogComponent>,
    private router: Router,
    @Inject(MAT_DIALOG_DATA) public editData: OrderBill
  ) {
    this.getRestaurantDetail();
  }

  ngOnInit(): void {
    this.orderItemDialogForm = this.formBuilder.group({
      name: [''],
      quantity: [''],
      cost: [''],
      amount: [''],
    });

    this.dataSource = new MatTableDataSource(this.editData.billItems);
  }

  getRestaurantDetail() {
    this.orderService.getRestaurantDetail().subscribe({
      next: (res: RestaurantDetail[]) => {
        this.restaurantDetails = res[0];
      },
      error: () => {
        alert('Error while reading Orders!');
      },
    });
  }

  printOrder() {
    let printContents = document.getElementById('printComponent')?.innerHTML;
    let popupWindow: Window | null;
    popupWindow = window.open('', '_blank');
    popupWindow?.window.focus();
    popupWindow?.document.write(String(printContents));
    popupWindow?.document.close();
    popupWindow?.print();

    this.orderService.completeOrder(this.editData.orderId).subscribe({
      next: () => {
        this.orderItemDialogForm.reset();
        this.orderItemDialog.close();
        this.router.navigate(['/order']);
      },
      error: () => {
        alert('Error while completing Order!');
      },
    });
  }
}
