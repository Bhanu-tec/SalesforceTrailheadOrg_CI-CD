import { LightningElement } from 'lwc';

export default class LifeCycleChildComponent extends LightningElement {

    constructor(){
        super();
        console.log('Constructor: Call from Child constructor');
    }

    connectedCallback(){
        console.log('ConnectedCallback: Call from Child connectedCallback');
    }
    
    renderedCallback(){
        console.log('RenderedCallback: Call from Child renderedCallback');
    }

    disconnectedCallback(){
        console.log('DisconnectedCallback: Call from Child disconnectedCallback');
    }
}