import { PrimaryCareGiverResolver } from './_services/primarycaregiver.resolver';
import { HeiComponent } from './hei/hei.component';
import { PreventiveServicesComponent } from './preventive-services/preventive-services.component';
import { HaartProphylaxisComponent } from './haart-prophylaxis/haart-prophylaxis.component';
import { ClientMonitoringComponent } from './client-monitoring/client-monitoring.component';
import { PatientEducationExaminationComponent } from './patient-education-examination/patient-education-examination.component';
import { AncComponent } from './anc/anc.component';

import { NgModule, Component } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { VisitDetailsComponent } from './visit-details/visit-details.component';
import { PlaceOfDeliveryResolver } from './_services/placeofdelivery.resolver';
import { DeliveryModeResolver } from './_services/deliverymode.resolver';
import { ARVProphylaxisResolver } from './_services/arvprophylaxis.resolver';
import { MotherStateResolver } from './_services/motherstate.resolver';
import { MotherReceiveDrugsResolver } from './_services/motherreceivedrugs.resolver';
import { HeiMotherRegimenResolver } from './_services/heimotherregimen.resolver';
import { YesNoResolver } from './_services/yesno.resolver';
import { MotherDrugsAtInfantEnrollmentResolver } from './_services/motherdrugsatinfantenrollment.resolver';
import { InfantFeedingOptionsResolver } from './_services/infant-feeding-options.resolver.service';
import {ImmunizationPeriodOptionsResolverService} from './_services/immunization-period-options-resolver.service';
import {ImmunizationGivenOptionsResolverService} from './_services/immunization-given-options-resolver.service';
import {MilestonesAssessedOptionsResolverService} from './_services/milestones-assessed-options-resolver.service';
import {MilestonesStatusOptionsResolverService} from './_services/milestones-status-options-resolver.service';
import { HeiOutcomeOptionsResolver } from './_services/hei-outcome-options.resolver.service';


const routes: Routes = [
    {
        path: '',
        component: VisitDetailsComponent,
        pathMatch: 'full',
    },
    {
        path: 'anc/:patientId/:personId/:serviceAreaId',
        component: AncComponent,
        pathMatch: 'full',
    },
    {
        path: 'pex',
        component: PatientEducationExaminationComponent,
        pathMatch: 'full',
    },
    {
        path: 'cm',
        component: ClientMonitoringComponent,
        pathMatch: 'full',
    },
    {
        path: 'haart',
        component: HaartProphylaxisComponent,
        pathMatch: 'full',
    },
    {
        path: 'ps',
        component: PreventiveServicesComponent,
        pathMatch: 'full',
    },
    {
        path: 'hei/:patientId/:personId/:serviceAreaId',
        component: HeiComponent,
        pathMatch: 'full',
        resolve: {
            placeofdeliveryOptions: PlaceOfDeliveryResolver,
            deliveryModeOptions: DeliveryModeResolver,
            arvprophylaxisOptions: ARVProphylaxisResolver,
            motherstateOptions: MotherStateResolver,
            motherreceivedrugsOptions: MotherReceiveDrugsResolver,
            heimotherregimenOptions: HeiMotherRegimenResolver,
            yesnoOptions: YesNoResolver,
            primarycaregiverOptions: PrimaryCareGiverResolver,
            motherdrugsatinfantenrollmentOptions: MotherDrugsAtInfantEnrollmentResolver,
            infantFeedingOptions: InfantFeedingOptionsResolver,
            immunizationPeriodOptions: ImmunizationPeriodOptionsResolverService,
            immunizationGivenOptions: ImmunizationGivenOptionsResolverService,
            milestoneAssessedOptions: MilestonesAssessedOptionsResolverService,
            milestoneStatusOptions: MilestonesStatusOptionsResolverService
            infantFeedingOptions: InfantFeedingOptionsResolver,
            heiOutcomeOptions: HeiOutcomeOptionsResolver
        }
    }
];


@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PmtctRoutingModule { }
