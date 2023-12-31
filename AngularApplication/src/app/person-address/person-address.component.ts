import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatDialog } from '@angular/material/dialog';
import { PersonAddressService } from './person-address.service';
import { PersonAddress, PersonAddressDialog } from './personAddress';
import { AddressDialogComponent } from './address-dialog/address-dialog.component';

@Component({
  selector: 'app-person-address',
  templateUrl: './person-address.component.html',
  styleUrls: ['./person-address.component.scss'],
})
export class PersonAddressComponent implements OnInit {
  constructor(
    private personAddressService: PersonAddressService,
    public dialog: MatDialog
  ) {
    this.getAllPersonAddress();
  }

  displayedColumns: string[] = [
    'AddressNo',
    'HouseNo',
    'Area',
    'City',
    'Zip',
    'action',
  ];

  dataSource!: MatTableDataSource<PersonAddress>;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  dialogAddressNo!: number;

  ngOnInit(): void {
    this.getAllPersonAddress();
  }

  getAllPersonAddress() {
    this.personAddressService
      .getAllPersonAddress(localStorage.getItem('personId'))
      .subscribe({
        next: (res: PersonAddress[]) => {
          if (res.length == 0) {
            this.dialogAddressNo = 1;
          } else {
            this.dialogAddressNo =
              Math.max(...res.map((item) => item.addressNo)) + 1;
          }
          this.dataSource = new MatTableDataSource(res);
          this.dataSource.paginator = this.paginator;
          this.dataSource.sort = this.sort;
        },
        error: () => {
          alert('Error while reading your Address!');
        },
      });
  }

  addPersonAddressDialog() {
    var dialogData: PersonAddressDialog = { addressNo: this.dialogAddressNo };
    const dialogRef = this.dialog.open(AddressDialogComponent, {
      width: '25%',
      data: dialogData,
    });
    dialogRef.afterClosed().subscribe((data) => {
      this.getAllPersonAddress();
    });
  }

  updatePersonAddressDialog(row: PersonAddress) {
    var dialogData: PersonAddressDialog = {
      addressNo: row.addressNo,
      personAddress: row,
    };
    const dialogRef = this.dialog.open(AddressDialogComponent, {
      width: '25%',
      data: dialogData,
    });
    dialogRef.afterClosed().subscribe((data) => {
      this.getAllPersonAddress();
    });
  }

  deletePersonAddress(row: any) {
    this.personAddressService
      .deletePersonAddress(localStorage.getItem('personId'), row.addressNo)
      .subscribe({
        next: () => {
          alert('Address deleted!');
          this.getAllPersonAddress();
        },
        error: (err: any) => {
          alert('Error while deleting Address!');
        },
      });
  }
}
