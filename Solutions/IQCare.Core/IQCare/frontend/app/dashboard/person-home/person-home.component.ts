import { Component, OnInit, NgZone } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { PersonHomeService } from '../services/person-home.service';
import { NotificationService } from '../../shared/_services/notification.service';
import { SnotifyService } from 'ng-snotify';
import { PersonView } from '../../records/_models/personView';

@Component({
    selector: 'app-person-home',
    templateUrl: './person-home.component.html',
    styleUrls: ['./person-home.component.css']
})
export class PersonHomeComponent implements OnInit {

    [x: string]: any;

    public personId = 0;
    public person: PersonView;
    public personView$: Subscription;
    services: any[];

    constructor(private route: ActivatedRoute,
        private personService: PersonHomeService,
        private snotifyService: SnotifyService,
        private notificationService: NotificationService,
        private router: Router,
        public zone: NgZone) {
        this.person = new PersonView();
    }

    ngOnInit() {
        this.route.params.subscribe(params => {
            this.personId = params['id'];
            console.log('personId' + this.personId);

            this.getPatientDetilsById(this.personId);
        });

        this.route.data.subscribe(res => {
            const { servicesArray } = res;

            this.services = servicesArray;
        });
    }

    public getPatientDetilsById(personId: number) {
        this.personView$ = this.personService.getPatientByPersonId(personId).subscribe(
            p => {
                console.log(p);
                this.person = p;
            },
            (err) => {
                this.snotifyService.error('Error editing encounter ' + err, 'person detail service',
                    this.notificationService.getConfig());
            },
            () => {
                // console.log(this.personView$);
            });
    }

    onEdit() {
        this.zone.run(() => {
            this.router.navigate(['/record/person/update/' + this.personId], { relativeTo: this.route });
        });
    }
}