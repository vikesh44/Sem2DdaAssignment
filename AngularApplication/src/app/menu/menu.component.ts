import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatDialog } from '@angular/material/dialog';
import { MenuService } from './menu.service';
import { MenuItem } from './menuItem';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss'],
})
export class MenuComponent implements OnInit {
  constructor(private modelService: MenuService, public dialog: MatDialog) {
    this.getAllMenuItems();
  }

  displayedColumns: string[] = [
    'ItemId',
    'Category',
    'Name',
    'Cost',
    'action',
  ];

  dataSource!: MatTableDataSource<MenuItem>;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;

  ngOnInit(): void {
    this.getAllMenuItems();
  }

  getAllMenuItems() {
    this.modelService.getAllMenus().subscribe({
      next: (res: MenuItem[] | undefined) => {
        this.dataSource = new MatTableDataSource(res);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      },
      error: () => {
        alert('Error while reading Menu Items!');
      },
    });
  }

  addMenuItemDialog() {
    // const dialogRef = this.dialog.open(MenuDialogComponent, {
    //   width: '25%'
    // });
  }

  updateMenuItemDialog(row: any) {
    // const dialogRef = this.dialog.open(MenuDialogComponent, {
    //   width: '25%',
    //   data: row
    // });
  }
  deleteMenuItem(row: any) {
    // this.modelService.deleteMenu(row.modelNumber).subscribe({
    //   next: () => {
    //     alert('Menu deleted!');
    //     this.getAllMenus();
    //   },
    //   error: (err: any) => {
    //     alert('Error while deleting user!');
    //   },
    // });
  }
}
