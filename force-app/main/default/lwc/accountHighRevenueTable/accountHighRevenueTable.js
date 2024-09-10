import { LightningElement, track, api } from 'lwc';

export default class LinkProducts extends LightningElement {
    @api recordId; // The ID of the parent record (e.g., C1)
    @track products = [];

    connectedCallback() {
        // Fetch the products from the server
        this.fetchProducts();
    }

    fetchProducts() {
        // Sample data, replace with a server call
        this.products = [
            { id: 'a2jC0000002o5r1IAA', name: 'P1', isLinked: false },
            { id: 'a2jC0000002o5i1AA', name: 'P2', isLinked: false },
            { id: 'a2jC0000003IQwWIAW', name: 'P3', isLinked: true }
        ];
    }

    handleRowClick(event) {
        const rowId = event.currentTarget.id;
        this.abacusRowId = rowId.replace('-0', '');  // Assuming '-0' needs to be removed from ID
        console.log('Row clicked: ', this.abacusRowId);
    }

    handleCheckboxChange(event) {
        const productId = event.target.dataset.id;
        const isChecked = event.target.checked;

        // Update the products array based on the checkbox change
        this.products = this.products.map(product => {
            if (product.id === productId) {
                return { ...product, isLinked: isChecked };
            }
            return product;
        });

        console.log('Updated Products: ', JSON.stringify(this.products));
    }

    handleClose() {
        // Logic to close the component or modal
    }
}

/*import { LightningElement,wire,track } from 'lwc';
import highRevenueAccounts from  '@salesforce/apex/AccountController.getHighRevenueAccounts';
const columns = [
    {label: 'Name', fieldName: 'Name', type: 'text'},
    {label: 'Account Number', fieldName: 'AccountNumber', type: 'text'},
    {label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency', typeAttributes:{currencyCode:'INR'}},
    {label: 'No.of Employees', fieldName: 'NumberOfEmployees', type: 'number'},
    {label: 'SIC Code', fieldName: 'Sic', type: 'number'}
];
export default class AccountHighRevenueTable extends LightningElement {  
    @track error;
    @track accountData;
    @track accountColumns = columns;
    rowsToShow = 5;  // Number of rows to initially display              
    @wire(highRevenueAccounts,{count:'$rowsToShow'})
    wiredAccounts({error,data}){

        if(data){
            this.accountData = data;
            //this.rowsToShow = data.slice(0, this.rowsToShow);// Show only initial rows
            this.error = undefined;
        }
        else if(error){
            this.error = error;
            this.accountData = undefined;
        }
    }

    setCount(event){
        let inputValue = event.target.value;
        if(inputValue == '') return;
        this.rowsToShow = event.target.value;
    }

}*/