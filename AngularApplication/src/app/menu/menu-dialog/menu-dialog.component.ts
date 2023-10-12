import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MenuService } from '../menu.service';
import { MenuItem, UpdateMenuItem } from '../menuItem';


@Component({
  selector: 'app-menu-dialog',
  templateUrl: './menu-dialog.component.html',
  styleUrls: ['./menu-dialog.component.scss'],
})
export class MenuDialogComponent implements OnInit {
  menuDialogForm!: FormGroup;
  buttonText: string = "Add";

  constructor(
    private formBuilder: FormBuilder,
    private menuService: MenuService,
    private menuDialog: MatDialogRef<MenuDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public editData: any
  ) { }

  ngOnInit(): void {
    this.menuDialogForm = this.formBuilder.group({
      itemId: ['', [Validators.required]],
      category: ['', Validators.required],
      name: ['', Validators.required],
      cost: ['', Validators.required],
    });

    if (this.editData) {
      this.buttonText = "Update";
      this.menuDialogForm.controls["itemId"].setValue(this.editData.itemId);
      this.menuDialogForm.controls["category"].setValue(this.editData.category);
      this.menuDialogForm.controls["name"].setValue(this.editData.name);
      this.menuDialogForm.controls["cost"].setValue(this.editData.cost);
    }
  }

  addUpdateMenuItem() {
    if (this.editData) {
      this.updateMenuItem();
    } else {
      this.addNewMenuItem();
    }
  }

  private addNewMenuItem() {
    var modelData: MenuItem = {
      itemId: this.menuDialogForm.value.itemId,
      category: this.menuDialogForm.value.category,
      name: this.menuDialogForm.value.name,
      cost: this.menuDialogForm.value.cost,
    };
    this.menuService.addMenuItem(modelData).subscribe({
      next: () => {
        this.menuDialogForm.reset();
        this.menuDialog.close();
        alert('Model Added Successfully.');
      },
      error: () => {
        alert('Error while adding Model.');
      },
    });
    return modelData;
  }

  private updateMenuItem() {
    var modelData: UpdateMenuItem = {
      category: this.menuDialogForm.value.category,
      name: this.menuDialogForm.value.name,
      cost: this.menuDialogForm.value.cost,
    };
    this.menuService.updateMenuItem(this.menuDialogForm.value.itemId, modelData).subscribe({
      next: () => {
        this.menuDialogForm.reset();
        this.menuDialog.close();
        alert('Model Updated Successfully.');
      },
      error: () => {
        alert('Error while Updating Model.');
      },
    });
  }
}
