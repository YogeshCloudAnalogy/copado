import { LightningElement } from 'lwc';
import user1 from '@salesforce/resourceUrl/user1';

export default class Login extends LightningElement {
    imgUrl = user1;
    userName ;
    password;

    handleUserName(event){
        console.log(event.target.value);
        this.userName = event.target.name;
    }
    handlePassword(event){
        console.log(event.target.value);
        this.password = event.target.name;
    }
    handleChecbox(event){
        let isTrue = event.target.checked;
        console.log(isTrue);
        const el = this.template.querySelector(".pwd");
        if(isTrue){
            el.type="text";
        }else{
            el.type="password";
        }
        
    }
    handleClick(event){
        let userEl = this.template.querySelector(".us");
        let pwd = this.template.querySelector(".pwd");
        console.log(this.userName != undefined);
        if(this.userName == undefined){
            console.log("first");
            userEl.setCustomValidity("please enter value");
        }
        else if(this.password == undefined){
            console.log("Second");
            userEl.setCustomValidity("");
            pwd.setCustomValidity("Please enter value");
        }else{
            userEl.setCustomValidity("");
            pwd.setCustomValidity("");
        }
        userEl.reportValidity();
        pwd.reportValidity();
    }
    handleSignup(event){
        let tabValue = "2";
        this.dispatchEvent(new CustomEvent("tabvaluechange",{detail:tabValue}));
    }
}