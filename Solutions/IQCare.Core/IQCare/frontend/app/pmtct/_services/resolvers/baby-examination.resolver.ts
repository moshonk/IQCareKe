import { Observable } from 'rxjs/index';
import { Resolve, RouterStateSnapshot, ActivatedRouteSnapshot } from '@angular/router';
import { LookupItemView } from '../../../shared/_models/LookupItemView';
import { Injectable } from '@angular/core';
import { LookupItemService } from '../../../shared/_services/lookup-item.service';

@Injectable()
export class BabyExaminationResolver implements Resolve<Observable<LookupItemView[]>> {
    /**
     *
     */
    constructor(private _lookupItemService: LookupItemService) {

    }

    public resolve(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot
    ): Observable<LookupItemView[]> {
        return this._lookupItemService.getByGroupName('BabyExamination');
    }
}
