/**  Copyright 2019 Google Inc. All Rights Reserved.
    Use of this source code is governed by an MIT-style license that
    can be found in the LICENSE file at http://angular.io/license */

import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatDialog } from '@angular/material/dialog';
import { FormGroup } from '@angular/forms';
import { OrderService } from '../order.service';
import { ActivatedRoute, Router } from '@angular/router';
import {
  BillItem,
  BillPersonInfo,
  GetOrderItem,
  OrderBill,
  OrderDialogData,
} from '../orderDto';
import { OrderItemDialogComponent } from '../order-item-dialog/order-item-dialog.component';
import { PrintOrderDialogComponent } from '../print-order/print-order.component';

@Component({
  selector: 'app-order-items',
  templateUrl: './order-items.component.html',
  styleUrls: ['./order-items.component.scss'],
})
export class OrderItemsComponent implements OnInit {
  orderItemsForm!: FormGroup;
  orderId!: string;

  constructor(
    private orderService: OrderService,
    public dialog: MatDialog,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) {}

  displayedColumns: string[] = ['OrderId', 'Name', 'Quantity', 'action'];

  dataSource!: MatTableDataSource<GetOrderItem>;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;

  ngOnInit(): void {
    this.activatedRoute.paramMap.subscribe((params) => {
      this.orderId = String(params.get('orderId'));
    });
    this.getAllOrderItems();
  }

  getAllOrderItems() {
    this.orderService.getOrderItems(this.orderId).subscribe({
      next: (res: GetOrderItem[] | undefined) => {
        this.dataSource = new MatTableDataSource(res);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      },
      error: () => {
        alert('Error while reading Order Items!');
      },
    });
  }

  addOrderItemDialog() {
    var modelData: OrderDialogData = {
      orderId: this.orderId,
    };
    const dialogRef = this.dialog.open(OrderItemDialogComponent, {
      width: '25%',
      data: modelData,
    });
    dialogRef.afterClosed().subscribe((_data) => {
      this.getAllOrderItems();
    });
  }

  updateOrderItemDialog(row: any) {
    var modelData: OrderDialogData = {
      orderId: this.orderId,
      orderItem: row,
    };
    const dialogRef = this.dialog.open(OrderItemDialogComponent, {
      width: '25%',
      data: modelData,
    });
    dialogRef.afterClosed().subscribe((_data) => {
      this.getAllOrderItems();
    });
  }

  print() {
    // console.log(this.dataSource);
    var billItems: BillItem[] = [];
    var billAmount: number = 0;
    this.dataSource.filteredData.forEach((data) => {
      let orderItem: BillItem = {
        name: data.name,
        cost: data.cost,
        quantity: data.quantity,
        amount: data.cost * data.quantity,
      };
      billAmount += orderItem.amount;
      billItems.push(orderItem);
    });

    let billPersonInfo: BillPersonInfo = this.orderService.getDataForPrint();

    var orderBill: OrderBill = {
      billItems: billItems,
      billPersonInfo: billPersonInfo,
      orderId: this.orderId,
      billAmount: billAmount,
    };

    const dialogRef = this.dialog.open(PrintOrderDialogComponent, {
      width: '25%',
      data: orderBill,
    });
    dialogRef.afterClosed().subscribe((_data) => {
      this.getAllOrderItems();
    });
  }

  deleteOrderItem(row: any) {
    this.orderService.deleteOrderItem(this.orderId, row.itemId).subscribe({
      next: () => {
        this.getAllOrderItems();
      },
      error: (_err: any) => {
        alert('Error while deleting item!');
      },
    });
  }

  completeOrder(row: any) {
    this.orderService.deleteOrderItem(this.orderId, row.itemId).subscribe({
      next: () => {
        this.getAllOrderItems();
      },
      error: (_err: any) => {
        alert('Error while deleting item!');
      },
    });
  }

  goBack() {
    this.router.navigate(['/order']);
  }
}
