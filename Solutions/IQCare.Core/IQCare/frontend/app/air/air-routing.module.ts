import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {ReportSectionSettingComponent} from './report-section-setting/report-section-setting.component';
import { IndicatorReportingPeriodComponent } from './indicator-reporting-period/indicator-reporting-period.component';
import { ReportIndicatorResultComponent } from './report-indicator-result/report-indicator-result.component';

const routes: Routes = [
     {
      path: '',
      component : IndicatorReportingPeriodComponent,
      children : [
        {
           path: 'report/:reportingFormId',
           component : IndicatorReportingPeriodComponent,
           pathMatch : 'full'
        }
      ],
     },
     {
      path: 'indicator/result/:reportingPeriodId',
      component : ReportIndicatorResultComponent,
      pathMatch : 'full'
    },
    {
        path: 'formdetails/:id/:reportingformid',
       component: ActiveFormReportComponent,
      resolve: {
          FormDetails: FormDetailResolver
         }
     },
     {
         path: 'sections/:id',
         component: ReportSectionSettingComponent,
         pathMatch: 'full'

     }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class AirRoutingModule { }

