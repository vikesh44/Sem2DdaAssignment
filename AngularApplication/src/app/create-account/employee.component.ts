import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatDialog } from '@angular/material/dialog';
import { AccountService } from './account.service';
import { Persondetail } from './personDetail';
import { CreateAccountComponent } from './create-account.component';

@Component({
  selector: 'app-employee',
  templateUrl: './employee.component.html',
  styleUrls: ['./employee.component.scss'],
})
export class EmployeeComponent implements OnInit {
  constructor(private accountService: AccountService, public dialog: MatDialog) {
    this.getAllEmployees();
  }

  displayedColumns: string[] = [
    'UserName',
    'EmailId',
    'DateOfBirth',
    'FirstName',
    'LastName',
    'PhoneNo',
    'action',
  ];

  dataSource!: MatTableDataSource<Persondetail>;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;

  ngOnInit(): void {
    this.getAllEmployees();
  }

  getAllEmployees() {
    this.accountService.getEmployees().subscribe({
      next: (res: Persondetail[] | undefined) => {
        this.dataSource = new MatTableDataSource(res);
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      },
      error: () => {
        alert('Error while reading Employees!');
      },
    });
  }

  addEmployeeDialog() {
    const dialogRef = this.dialog.open(CreateAccountComponent, {
      width: '25%'
    });
  }

  updateEmployeeDialog(row: any) {
    const dialogRef = this.dialog.open(CreateAccountComponent, {
      width: '25%',
      data: row
    });
  }
  deleteEmployee(row: any) {
    this.accountService.deletePerson(row.personId, false).subscribe({
      next: () => {
        alert('Employee deleted!');
        this.getAllEmployees();
      },
      error: (err: any) => {
        alert('Error while deleting Employee!');
      },
    });
  }
}
