import { LookupItemService } from './../../../shared/_services/lookup-item.service';
import { LookupItemView } from './../../../shared/_models/LookupItemView';
import { Observable } from 'rxjs/index';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Injectable } from '@angular/core';

@Injectable()
export class FamilyPlanningMethodResolver implements Resolve<Observable<LookupItemView[]>> {
    /**
     *
     */
    constructor(private _lookupItemService: LookupItemService) {

    }

    public resolve(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot
    ): Observable<LookupItemView[]> {
        return this._lookupItemService.getByGroupName('FPMethod');
    }
}
