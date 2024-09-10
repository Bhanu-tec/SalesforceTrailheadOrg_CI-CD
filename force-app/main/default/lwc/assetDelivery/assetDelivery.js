import { LightningElement, track, api, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import { subscribe, unsubscribe } from 'lightning/empApi';
import ASSET_IDENTIFIER_FIELD from "@salesforce/schema/Asset.Asset_Identifier__c";

export default class AssetDelivery extends LightningElement {
    @api recordId;
    @track recIdentifier;
    @track current;
    subscription = {};
    channelName = '/event/Asset_Disconnection__e';

    @wire(getRecord, {recordId: "$recordId", fields: [ASSET_IDENTIFIER_FIELD]})
    asset({error, data}){
        if(data){
          this.recIdentifier = getFieldValue(data, ASSET_IDENTIFIER_FIELD);
        }else if(error){
          console.log(JSON.stringify(error)); 
        }
    }

    connectedCallback() {
        this.handleSubscribe();
    }

    handleSubscribe() {
        const messageCallback = (response) => {
            console.log('New message received: ', JSON.stringify(response));
            const assetId = response.data.payload.Asset_Identifier__c;
            const isDisconnected = response.data.payload.Disconnected__c;

            if (assetId === this.recIdentifier && isDisconnected) {
                this.current = 'Disconnected'; // Update your progress here
            }
        };

        subscribe(this.channelName, -1, messageCallback)
            .then(response => {
                this.subscription = response;
                console.log('Subscribed to channel:', this.channelName);
            })
            .catch(error => {
                console.error('Subscription error:', error);
            });
    }

    disconnectedCallback() {
        this.handleUnsubscribe();
    }

    handleUnsubscribe() {
        if (this.subscription) {
            unsubscribe(this.subscription)
                .then(() => {
                    console.log('Unsubscribed from channel');
                    this.subscription = null;
                })
                .catch(error => {
                    console.error('Unsubscribe error:', error);
                });
        }
    }
}
