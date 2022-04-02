import { LightningElement } from 'lwc';

export default class LoginSigupController extends LightningElement {
    activeTab;
    handleActiveTab(event){
        console.log("event value",event.detail);
        this.activeTab = event.detail;
    }
    handleActive(event) {
        console.log("hello from");
        this.activeTab = event.target.value;
        console.log(event.target.value, this.activeTab);
    }
}