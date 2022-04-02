import { LightningElement, wire } from 'lwc';
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext,
    createMessageContext
} from 'lightning/messageService';
import sampleMessage from '@salesforce/messageChannel/SampleMessageChannel__c';

export default class LwcSubscriber extends LightningElement {
    messageContext = createMessageContext();
    connectedCallback(){
        this.subscribeToMessageChannel();
    }
    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                sampleMessage,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }
    handleMessage(message){
        alert(message);
    }
    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}