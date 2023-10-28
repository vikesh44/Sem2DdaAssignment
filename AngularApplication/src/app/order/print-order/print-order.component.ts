import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { OrderService } from '../order.service';
import { OrderBill, RestaurantDetail } from '../orderDto';
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
  menuItems: MenuItem[] = [];
  restaurantDetails: RestaurantDetail = {
    fssaiNo: '11523852123456',
    name: '',
    area: '',
    city: '',
    zip: '',
  };
  dataSource!: MatTableDataSource<OrderBill>;

  displayedColumns: string[] = ['Name', 'Quantity', 'Cost', 'Amount'];

  constructor(
    private formBuilder: FormBuilder,
    private orderService: OrderService,
    @Inject(MAT_DIALOG_DATA) public editData: OrderBill[]
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

    this.dataSource = new MatTableDataSource(this.editData);
  }

  getRestaurantDetail() {
    this.orderService.getRestaurantDetail().subscribe({
      next: (res: RestaurantDetail[]) => {
        this.restaurantDetails = res[0];
        console.log(this.restaurantDetails);
      },
      error: () => {
        alert('Error while reading Orders!');
      },
    });
  }

  addUpdateOrderItem() {}
}
