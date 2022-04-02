import { LightningElement, wire } from 'lwc';
import { publish, MessageContext,createMessageContext } from 'lightning/messageService';
import sampleMessage from '@salesforce/messageChannel/SampleMessageChannel__c';

export default class LWCPublish extends LightningElement {
    context = createMessageContext();
        handleClick(event){
        event.preventDefault();
        let paylod = {
            recordId : "this is recordId",
            recordData : "this is record Data"
        }
        console.log(paylod);
        console.log(publish);
        publish(this.context,sampleMessage,paylod);
    }
}