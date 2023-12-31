import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { MenuComponent } from './menu/menu.component';
import { AuthGuard } from './shared/auth.guard';
import { TemplateComponent } from './template/template.component';
import { CreateAccountComponent } from './create-account/create-account.component';
import { ProfileComponent } from './profile/profile.component';
import { ForgotPasswordComponent } from './login/forgot-password.component';
import { EmployeeComponent } from './create-account/employee.component';
import { PersonAddressComponent } from './person-address/person-address.component';
import { OrderComponent } from './order/order.component';
import { OrderItemsComponent } from './order/order-items/order-items.component';
import { RoleGuard } from './shared/role.guard';
import { ChefDisplayComponent } from './order/chef-display/chef-display.component';

const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'login', component: LoginComponent },
  { path: 'create-account', component: CreateAccountComponent },
  { path: 'forgot-password', component: ForgotPasswordComponent },
  {
    path: '', component: TemplateComponent, children: [
      { path: 'menu', component: MenuComponent, canActivate: [AuthGuard] },
      { path: 'profile', component: ProfileComponent, canActivate: [AuthGuard] },
      { path: 'address', component: PersonAddressComponent, canActivate: [AuthGuard] },
      { path: 'employee', component: EmployeeComponent, canActivate: [RoleGuard] },
      { path: 'order', component: OrderComponent, canActivate: [AuthGuard] },
      { path: 'order-items/:orderId/:isCompleted', component: OrderItemsComponent, canActivate: [AuthGuard] },
      { path: 'chef-display', component: ChefDisplayComponent, canActivate: [RoleGuard] },
    ],
  },
  { path: '**', redirectTo: 'login' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
