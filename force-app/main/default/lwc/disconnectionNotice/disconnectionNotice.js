import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class DisconnectionNotice extends LightningElement {
    subscription = {};
    status;
    identifier;
    channelName;

    connectedCallback() {
        //this.handleSubscribe();
    }

    renderedCallback(){
        
    }

    handleSubscribe() {
        //Implement your subscribing solution here 
    }

    disconnectedCallback() {
        //Implement your unsubscribing solution here
    }

    showSuccessToast(assetId) {
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Asset Id '+assetId+' is now disconnected',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

    showErrorToast() {
        const event = new ShowToastEvent({
            title: 'Error',
            message: 'Asset was not disconnected. Try Again.',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

}