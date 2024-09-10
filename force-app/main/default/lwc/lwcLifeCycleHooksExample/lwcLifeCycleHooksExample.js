import { LightningElement } from 'lwc';

export default class LwcLifeCycleHooksExample extends LightningElement {

    isVisible = true;

    constructor(){
        super();
        console.log('Constructor: Component instance is created');
    }

    connectedCallback(){

        console.log('ConnectedCallback: Component is inserted into the DOM');
    }

    renderedCallback(){
        console.log('RenderedCallback: Component’s template has been rendered');
    }

    errorCallback(){
        console.log('ErrorCallback: Component encountered an error');
    }

    // disconnectedCallback(){
    //     console.log('DisconnectedCallback: Component is disconnected');
    // }
    
    handleClick(){
        
        if(this.isVisible == true){
            this.isVisible = false;
        }else{
            this.isVisible = true;
        }
    }
}