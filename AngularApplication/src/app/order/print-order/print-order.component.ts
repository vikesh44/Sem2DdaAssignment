import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { OrderBill } from '../orderDto';
import { MenuItem } from 'src/app/menu/menuItem';
import { ActivatedRoute } from '@angular/router';
import { MatTableDataSource } from '@angular/material/table';

@Component({
  selector: 'app-print-order',
  templateUrl: './print-order.component.html',
  styleUrls: ['./print-order.component.scss'],
})
export class PrintOrderDialogComponent implements OnInit {
  orderItemDialogForm!: FormGroup;
  orderId!: string;
  menuItems: MenuItem[] = [];
  dataSource!: MatTableDataSource<OrderBill>;

  displayedColumns: string[] = ['Name', 'Quantity', 'Cost', 'Amount'];

  constructor(
    private formBuilder: FormBuilder,
    private orderService: OrderService,
    @Inject(MAT_DIALOG_DATA) public editData: OrderBill[],
    private activatedRoute: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.orderItemDialogForm = this.formBuilder.group({
      name: [''],
      quantity: [''],
      cost: [''],
      amount: [''],
    });

    this.activatedRoute.paramMap.subscribe((params) => {
      this.orderId = String(params.get('orderId'));
    });

    console.log(this.editData);

    this.dataSource = new MatTableDataSource(this.editData);
  }

  addUpdateOrderItem() {}
}
