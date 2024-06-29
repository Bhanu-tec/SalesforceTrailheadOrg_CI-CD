import { LightningElement, track, api, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import ASSET_IDENTIFIER_FIELD from "@salesforce/schema/Asset.Asset_Identifier__c";

export default class AssetDelivery extends LightningElement {
    progressValue = 0;
    @api 
    recordId;
    recIdentifier;
    current;

    @wire(getRecord, {recordId: "$recordId", fields: [ASSET_IDENTIFIER_FIELD]})
    asset({error, data}){
        if(data){
          this.recIdentifier = getFieldValue(data, ASSET_IDENTIFIER_FIELD);
        }else if(error){
          console.log(JSON.stringify(error)); 
        }
      }

    connectedCallback() {
        
    }

    renderedCallback(){
        //this.handleSubscribe();
    }

    handleSubscribe() {
        // Implement messageCallback and subscribe here 
    }

}