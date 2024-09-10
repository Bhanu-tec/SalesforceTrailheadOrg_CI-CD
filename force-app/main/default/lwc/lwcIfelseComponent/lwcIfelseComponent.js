import { LightningElement, api } from 'lwc';

export default class IfExample extends LightningElement {
    @api value;

    refresh() {
        this.value = !this.value;
    }
}