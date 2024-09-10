import { LightningElement, api, wire, track } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { getRecord } from 'lightning/uiRecordApi';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAssets from '@salesforce/apex/AssetController.getAssets';

const columns = [
    { label: 'Asset Name', fieldName: 'Name' }
];

export default class AssetList extends LightningElement {
    @api recordId;
    @track searchTerm = '';
    @track assets = [];
    @track filteredAssets = [];
    @track selectedAssets = [];

    @wire(getRecord, { recordId: '$recordId', fields: ['WorkOrder.Name'] })
    workOrderRecord;

    @wire(getAssets)
    wiredAssets({ error, data }) {
        if (data) {
            this.assets = data;
            this.filteredAssets = data;
        } else if (error) {
            console.error(error);
        }
    }

    get columns() {
        return columns;
    }

    handleSearch(event) {
        this.searchTerm = event.target.value.toLowerCase();
        this.filteredAssets = this.assets.filter(asset => asset.Name.toLowerCase().includes(this.searchTerm));
    }

    handleRowSelection(event) {
        this.selectedAssets = event.detail.selectedRows;
    }

    handleNext() {
        this.dispatchEvent(new CloseActionScreenEvent());
        const workOrderId = this.workOrderRecord.data.fields.Name.value;

        const lineItems = this.selectedAssets.map(asset => {
            return {
                WorkOrder__c: workOrderId,
                Asset__c: asset.Id
            };
        });

        const recordInputs = lineItems.map(lineItem => {
            return { apiName: 'Work_Order_Line_Item__c', fields: lineItem };
        });

        createRecord(recordInputs)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Assets inserted as Work Order Line Items',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.error(error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}