import { LightningElement, track } from 'lwc';

export default class SearchComponent extends LightningElement {
    
    @track searchKey;
    handleChange(event){
        console.log('Search Event Started ');
        const searchKey = event.target.value;
        event.preventDefault();
        const searchEvent = new CustomEvent(
            'change', 
            { 
                detail : searchKey
            }
        );
        this.dispatchEvent(searchEvent);
    }
}