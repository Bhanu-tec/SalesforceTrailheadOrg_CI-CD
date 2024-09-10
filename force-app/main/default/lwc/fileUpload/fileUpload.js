import { LightningElement, track } from 'lwc';
import loadCSVData from '@salesforce/apex/CSVController.loadCSVData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FileUpload extends LightningElement {
    //@track fileList = [];
    @track contentDocumentId = [];

    get acceptedFormats() {
        return ['.csv'];
    }
    fileData = [];
    openfileUpload(event) {
        const uploadedFiles = event.detail.files;
        
        // Loop through each uploaded file
        for (let i = 0; i < uploadedFiles.length; i++) {
            // Store each documentId in the array
            this.contentDocumentId.push(uploadedFiles[i].documentId);  
            this.fileData.push(uploadedFiles[i].name);
            // Optionally, you can log file name as well
            console.log('File Name:', uploadedFiles[i].name);
        }
        // const file = event.target.files[0]
        // var reader = new FileReader()
        // reader.onload = () => {
        //     var base64 = reader.result.split(',')[1]
        //     this.fileData = {
        //         'filename': file.name,
        //         'base64': base64,
        //         'recordId': this.recordId
        //     }
        //     console.log(this.fileData)
        // }
        // reader.readAsDataURL(file)
    }
    
    handleClick(){
        //const {base64, filename, recordId} = this.fileData
       // const contentDocumentIds = this.fileList.map(file => file.id);
        loadCSVData({contentDocumentId : this.contentDocumentId})
        // .then(result=>{
        //     this.fileData = null
        //     let title = `${filename} uploaded successfully!!`
        //     this.toast(title)
        // })
    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title, 
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }
}