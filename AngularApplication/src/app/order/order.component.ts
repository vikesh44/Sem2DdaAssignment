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

@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.scss'],
})
export class OrderComponent implements OnInit {
  createOrderDialogForm!: FormGroup;

  constructor(private orderService: OrderService,
              public dialog: MatDialog,
              private formBuilder: FormBuilder) {
  }

  displayedColumns: string[] = [
    'OrderId',
    'CustomerId',
    'EmployeeId',
    'TableId',
    'OrderType',
    'Cost',
    'IsCompleted',
    'IsReservation',
    // 'action',
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
  }
}

// import {Component, OnInit, ViewChild} from '@angular/core';
// import {MatPaginator} from '@angular/material/paginator';
// import {MatTableDataSource} from '@angular/material/table';
// import {MatSort} from '@angular/material/sort';

// import { FormGroup, FormControl, Validators } from '@angular/forms';

// export interface EditUserDto {
//   id: number;
//   firstName: string;
//   lastName: string;
//   username: string;
//   email: string;
//   project: string;
//   team: string;
// }

// export interface EditUser {
//   currentData?: EditUserDto;
//   originalData: EditUserDto;
//   editable: boolean;
//   validator: FormGroup;
// }

// /**
//  * @title Basic use of `<table mat-table>`
//  */
// @Component({
//   selector: 'app-order',
//   templateUrl: './order.component.html',
//   styleUrls: ['./order.component.scss'],
// })

// export class OrderComponent {
// ELEMENT_DATA_FROM_BACK: EditUserDto[] = [
//     {id: 1, firstName: 'Ion', lastName: 'Popescu', username: 'ipopescu', email: 'ion.popescu@domain.com', project: 'bench', team: ''},
//     {id: 2, firstName: 'Ion', lastName: 'Vasile', username: 'ivasile', email: 'ion.vasile@domain.com', project: 'bench', team: ''},
//     {id: 3, firstName: 'Gigel', lastName: 'Popescu', username: 'gpopescu', email: 'gigel.popescu@domain.com', project: 'bench', team: ''},
//     {id: 4, firstName: 'Dorel', lastName: 'Popescu', username: 'dpopescu', email: 'dorel.popescu@domain.com', project: 'bench', team: ''},
//     {id: 5, firstName: 'Cardel', lastName: 'Popescu', username: 'cpopescu', email: 'cardel.popescu@domain.com', project: 'bench', team: ''},
//     {id: 6, firstName: 'Alex', lastName: 'Popescu', username: 'apopescu', email: 'alex.popescu@domain.com', project: 'bench', team: ''},
//     {id: 7, firstName: 'Mihai', lastName: 'Popescu', username: 'mpopescu', email: 'mihai.popescu@domain.com', project: 'bench', team: ''}
//   ];

//   ELEMENT_DATA: EditUser[] = [];

//   displayedColumns: string[] = ['id', 'firstName', 'lastName', 'username', 'email', 'project', 'team', 'action'];
//   dataSource!: MatTableDataSource<EditUser>;
//   selected = 'option1';

//   @ViewChild(MatPaginator, {static: true}) paginator!: MatPaginator;
//   @ViewChild(MatSort, {static: true}) sort!: MatSort;
//   editForm!: FormGroup;

//   constructor() {
//     const editForm = (e: EditUserDto) => new FormGroup({
//       firstName: new FormControl(e.firstName,Validators.required),
//       lastName: new FormControl(e.lastName,Validators.required),
//       username: new FormControl(e.username,Validators.required),
//       email: new FormControl(e.email,Validators.required),
//     });
//     this.ELEMENT_DATA_FROM_BACK.forEach(element => {
//       this.ELEMENT_DATA.push({currentData: element,
//                               originalData: element,
//                               editable: false,
//                               validator: editForm(element)});
//     });
//   }

//   ngOnInit() {
//     this.dataSource = new MatTableDataSource(this.ELEMENT_DATA.slice());
//     this.dataSource.paginator = this.paginator;
//     this.dataSource.sort = this.sort;
//   }

//   applyFilter(filterValue: string) {
//     this.dataSource.filter = filterValue.trim().toLowerCase();
//   }

//   deleteRow(index: number) {
//     const data = this.dataSource.data;
//     data.splice((this.paginator.pageIndex * this.paginator.pageSize) + index, 1);

//     this.dataSource.data = data;
//   }

//     confirmEditCreate(row: { editable: boolean; validator: { controls: { [x: string]: { value: any; }; }; }; currentData: { [x: string]: any; }; }) {
//       row.editable = false;
//       // save form control values to data object
//       Object.keys(row.validator.controls).forEach(item => {
//         row.currentData[item] = row.validator.controls[item].value;
//       });
//     }

//     startEdit(row: { editable: boolean; }) {
//       row.editable = true;
//     }

//     cancelOrDelete(row: { editable: boolean; validator: { controls: { [x: string]: { patchValue: (arg0: any) => void; }; }; }; currentData: { [x: string]: any; }; }, i: number) {
//       if (row.editable) {
//         row.editable = false;
//         // cancel - reset form control values to data object
//         Object.keys(row.validator.controls).forEach(item => {
//           row.validator.controls[item].patchValue(row.currentData[item]);
//         });
//       }
//       else {
//         // delete
//         this.deleteRow(i);
//       }
//     }
// }
