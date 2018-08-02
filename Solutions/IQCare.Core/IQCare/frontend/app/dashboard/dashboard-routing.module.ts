
import { PersonHomeComponent } from './person-home/person-home.component';
import { NgModule, Component } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PortalComponent } from './portal/portal.component';

const routes: Routes = [
    {
        path: '',
        component: PortalComponent,
        pathMatch: 'full',
    },
    {
        path: 'personHome',
        component: PersonHomeComponent,
        pathMatch: 'full',
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DashboardRoutingModule { }