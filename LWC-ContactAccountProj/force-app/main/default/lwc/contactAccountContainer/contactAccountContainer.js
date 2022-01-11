import { LightningElement } from 'lwc';

export default class ContactAccountContainer extends LightningElement {

    handleRecord(event) {
        console.log( JSON.stringify ( event.detail) )
        this.template.querySelector('c-account-search-component').conId = event.detail.data.record.Id;
        console.log(event.detail.data.record.Id);
    }
}