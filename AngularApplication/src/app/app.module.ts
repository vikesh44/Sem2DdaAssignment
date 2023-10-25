import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { NoopAnimationsModule } from '@angular/platform-browser/animations';

import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { MenuComponent } from './menu/menu.component';
import { TemplateComponent } from './template/template.component';
import { MenuDialogComponent } from './menu/menu-dialog/menu-dialog.component';
import { CreateAccountComponent } from './create-account/create-account.component';
import { ProfileComponent } from './profile/profile.component';
import { ForgotPasswordComponent } from './login/forgot-password.component';
import { EmployeeComponent } from './create-account/employee.component';
import { PersonAddressComponent } from './person-address/person-address.component';
import { AddressDialogComponent } from './person-address/address-dialog/address-dialog.component';
import { OrderComponent } from './order/order.component';
import { CreateOrderDialogComponent } from './order/create-order-dialog/create-order.component';

import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { TokenInterceptor } from 'src/app/interceptor/token.interceptor';
import { DatePipe } from '@angular/common';

import { MatCardModule } from '@angular/material/card';
import { MatDividerModule } from '@angular/material/divider';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatDialogModule } from '@angular/material/dialog';
import { MatSortModule } from '@angular/material/sort';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatMenuModule } from '@angular/material/menu';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { OrderItemsComponent } from './order/order-items/order-items.component';
import { OrderItemDialogComponent } from './order/order-item-dialog/order-item-dialog.component';

const MaterialComponents = [
  BrowserModule,
  AppRoutingModule,
  NoopAnimationsModule,
  HttpClientModule,
  MatCardModule,
  MatDividerModule,
  FormsModule,
  ReactiveFormsModule,
  MatIconModule,
  MatButtonModule,
  MatFormFieldModule,
  MatInputModule,
  MatTableModule,
  MatPaginatorModule,
  MatSidenavModule,
  MatListModule,
  MatToolbarModule,
  MatDialogModule,
  MatSortModule,
  MatDatepickerModule,
  MatNativeDateModule,
  MatMenuModule,
  MatCheckboxModule,
  MatRadioModule,
  MatSelectModule,
];

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    TemplateComponent,
    MenuComponent,
    MenuDialogComponent,
    CreateAccountComponent,
    ProfileComponent,
    ForgotPasswordComponent,
    EmployeeComponent,
    PersonAddressComponent,
    AddressDialogComponent,
    OrderComponent,
    CreateOrderDialogComponent,
    OrderItemsComponent,
    OrderItemDialogComponent,
  ],
  imports: [MaterialComponents],
  providers: [
    DatePipe,
    {
      provide: HTTP_INTERCEPTORS,
      useClass: TokenInterceptor,
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
