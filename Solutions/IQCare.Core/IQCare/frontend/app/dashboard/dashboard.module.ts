import { PersonHomeComponent } from './person-home/person-home.component';
import { SearchComponent } from './search/search.component';
import { PortalComponent } from './portal/portal.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardRoutingModule } from './dashboard-routing.module';

@NgModule({
  imports: [
    CommonModule,
    DashboardRoutingModule
  ],
  declarations: [
    PortalComponent,
    SearchComponent,
    PersonHomeComponent
  ]
})
export class DashboardModule { }
