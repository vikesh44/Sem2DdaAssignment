/**  Copyright 2019 Google Inc. All Rights Reserved.
    Use of this source code is governed by an MIT-style license that
    can be found in the LICENSE file at http://angular.io/license */

import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatDialog } from '@angular/material/dialog';
import { OrderService } from './order.service';
import { PersonOrder } from './orderDto';
import { CreateOrderDialogComponent } from './create-order-dialog/create-order.component';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Persondetail } from '../create-account/personDetail';
import { Router } from '@angular/router';

@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.scss'],
})
export class OrderComponent implements OnInit {
  createOrderDialogForm!: FormGroup;

  constructor(
    private orderService: OrderService,
    public dialog: MatDialog,
    private router: Router
  ) {}

  displayedColumns: string[] = [
    'OrderId',
    'CustomerName',
    'EmployeeName',
    'TableId',
    'OrderType',
    'Cost',
    'IsCompleted',
    'IsReservation',
    'action',
  ];

  dataSource!: MatTableDataSource<PersonOrder>;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  employeesData: Persondetail[] = [];

  ngOnInit(): void {
    this.getAllOrders();
  }

  getAllOrders() {
    this.orderService.getAllOrders(false).subscribe({
      next: (res: PersonOrder[] | undefined) => {
        this.dataSource = new MatTableDataSource(res);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      },
      error: () => {
        alert('Error while reading Orders!');
      },
    });
  }

  createOrder() {
    const dialogRef = this.dialog.open(CreateOrderDialogComponent, {
      width: '25%',
    });
    dialogRef.afterClosed().subscribe((data) => {
      this.getAllOrders();
    });
  }

  gotoOrderItems(row: PersonOrder) {
    this.router.navigate(['/order-items/' + row.orderId]);
  }
}
