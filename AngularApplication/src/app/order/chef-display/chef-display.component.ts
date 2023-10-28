/**  Copyright 2019 Google Inc. All Rights Reserved.
    Use of this source code is governed by an MIT-style license that
    can be found in the LICENSE file at http://angular.io/license */

import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatDialog } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { ChefDisplay } from '../orderDto';

@Component({
  selector: 'app-chef-display',
  templateUrl: './chef-display.component.html',
  styleUrls: ['./chef-display.component.scss'],
})
export class ChefDisplayComponent implements OnInit {
  constructor(private orderService: OrderService, public dialog: MatDialog) {
  }

  displayedColumns: string[] = ['ItemId', 'Name', 'Quantity'];

  dataSource!: MatTableDataSource<ChefDisplay>;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;

  ngOnInit(): void {
    this.getChefDisplay();
  }

  getChefDisplay() {
    this.orderService.getChefDisplay().subscribe({
      next: (res: ChefDisplay[] | undefined) => {
        this.dataSource = new MatTableDataSource(res);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      },
      error: () => {
        alert('Error while reading Items!');
      },
    });
  }
}
