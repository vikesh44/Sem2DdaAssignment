/**  Copyright 2019 Google Inc. All Rights Reserved.
    Use of this source code is governed by an MIT-style license that
    can be found in the LICENSE file at http://angular.io/license */

import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatDialog } from '@angular/material/dialog';
import { FormBuilder, FormGroup } from '@angular/forms';
import { OrderService } from '../order.service';
import { ActivatedRoute } from '@angular/router';
import { OrderDialogData, OrderItem } from '../orderDto';
import { MenuItem } from 'src/app/menu/menuItem';
import { OrderItemDialogComponent } from '../order-item-dialog/order-item-dialog.component';
import { AuthService } from 'src/app/shared/auth.service';

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
    private activatedRoute:ActivatedRoute
  ) {}

  displayedColumns: string[] = [
    'OrderId',
    'ItemId',
    'Quantity',
    'action',
  ];

  dataSource!: MatTableDataSource<OrderItem>;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  employeesData: OrderItem[] = [];

  ngOnInit(): void {
    this.activatedRoute.paramMap.subscribe((params) => {
      this.orderId = String(params.get("orderId"));
    });
    this.getAllOrderItems();
  }

  getAllOrderItems() {
    this.orderService.getOrderItems(this.orderId).subscribe({
      next: (res: OrderItem[] | undefined) => {
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
      orderId: this.orderId
    };
    const dialogRef = this.dialog.open(OrderItemDialogComponent, {
      width: '25%',
      data: modelData
    });
    dialogRef.afterClosed().subscribe(_data =>{
      this.getAllOrderItems();
    })
  }

  updateOrderItemDialog(row: any) {
    var modelData: OrderDialogData = {
      orderId: this.orderId,
      orderItem: row
    };
    const dialogRef = this.dialog.open(OrderItemDialogComponent, {
      width: '25%',
      data: modelData
    });
    dialogRef.afterClosed().subscribe(_data =>{
      this.getAllOrderItems();
    })
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
}
