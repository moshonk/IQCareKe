import { LookupItemView } from './../../shared/_models/LookupItemView';
import { Observable } from 'rxjs/index';
import { Resolve, RouterStateSnapshot, ActivatedRouteSnapshot } from '@angular/router';
import { Injectable } from '@angular/core';
import { LookupItemService } from '../../shared/_services/lookup-item.service';

@Injectable()
export class YesNoDontKnowResolver implements Resolve<Observable<LookupItemView[]>> {
    /**
     *
     */
    constructor(private lookupItemService: LookupItemService) {

    }

    public resolve(
        route: ActivatedRouteSnapshot,
        state: RouterStateSnapshot
    ): Observable<LookupItemView[]> {
        return this.lookupItemService.getByGroupName('YesNoDont_Know');
    }
}