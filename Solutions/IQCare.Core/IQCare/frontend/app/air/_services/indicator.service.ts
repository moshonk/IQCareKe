import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ErrorHandlerService } from '../../shared/_services/errorhandler.service';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { catchError, tap } from 'rxjs/operators';


@Injectable({
  providedIn: 'root'
})
export class IndicatorService {

  constructor(private httpClient: HttpClient,
     private errorHandlerService: ErrorHandlerService) { 
  }
  
  private Air_WebApiUrl = environment.API_AIR_URL;
 
  public getFormIndicatorReportingPeriods(): Observable<any> {
    return this.httpClient.get<any>(this.Air_WebApiUrl + '/api/ReportingForm/GetReportingFormPeriods').pipe(
      tap(indicatorReportingPeriod => this.errorHandlerService.log('get form indicator reporting periods')),
      catchError(this.errorHandlerService.handleError<any[]>('getFormIndicatorReportingPeriods'))
  );      
  }
}
