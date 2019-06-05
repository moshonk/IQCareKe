import { CccComponent } from './enrollment/service-areas/ccc/ccc.component';
import { EnrollmentServicesComponent } from './enrollment/enrollment-services/enrollment-services.component';
import { ServicesResolver } from './services/services.resolver';
import { PersonHomeComponent } from './person-home/person-home.component';
import { NgModule, Component } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PortalComponent } from './portal/portal.component';
import { HtsComponent } from './enrollment/service-areas/hts/hts.component';
import { HTSEncounterResolver } from './services/htsencounter.resolver';
import { PersonCurrentVitalsResolver } from './services/personvitals.resolver';
import { RiskEncounterResolver} from './services/riskencounter.resolver';

const routes: Routes = [
    {
        path: '',
        component: PortalComponent,
        pathMatch: 'full',
    },
    {
        path: 'personhome/:id',
        component: PersonHomeComponent,
        resolve: {
            servicesArray: ServicesResolver,
            HTSEncounterArray: HTSEncounterResolver,
            PersonVitalsArray: PersonCurrentVitalsResolver,
            RiskAssessmentArray: RiskEncounterResolver
        }
    },
    {
        path: 'enrollment',
        children: [
            {
                path: ':id/:serviceId/:serviceCode',
                component: EnrollmentServicesComponent
            },
            {
                path: 'hts',
                children: [
                    {
                        path: ':id/:serviceId/:serviceCode',
                        component: HtsComponent
                    },
                    {
                        path: 'update/:id/:serviceId/:serviceCode/:edit',
                        component: HtsComponent
                    }
                ]

            },
            {
                path: 'ccc',
                children: [
                    {
                        path: ':id/:serviceId/:serviceCode',
                        component: CccComponent
                    },
                    {
                        path: 'update/:id/:serviceId/:serviceCode/:edit',
                        component: CccComponent
                    }
                ]
            }
        ]
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DashboardRoutingModule { }
