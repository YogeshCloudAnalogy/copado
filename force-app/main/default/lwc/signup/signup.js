import { LightningElement } from 'lwc';
import user1 from '@salesforce/resourceUrl/user1';
import createAccount from '@salesforce/apex/SignupController.createAccount';


export default class Signup extends LightningElement {
    imgUrl = user1;
    userName;
    password;
    confirmPassword;
    userEmail;
    handleUserName(event){
        this.userName = event.target.value;
    }
    handleUserEmail(event){
        this.userEmail = event.target.value;
    }
    handlePassword(event){
        this.password = event.target.value;
    }
    handleConfirmPassword(event){
        this.confirmPassword = event.target.value;
    }
    handleSignup(event){
        const nameEl = this.template.querySelector(".us");
        const emaiEl = this.template.querySelector(".mail");
        const pwd  = this.template.querySelector(".pwd");
        const pwd2 = this.template.querySelector(".pwd2");
        if(this.userName == undefined){
            nameEl.setCustomValidity("please enter name of user");
        }else if(this.userEmail == undefined){
            nameEl.setCustomValidity("");
            emaiEl.setCustomValidity("please enter Email of user");
        }
        else{
            nameEl.setCustomValidity("");
            emaiEl.setCustomValidity("");
            createAccount({"userName":this.userName,"email":this.userEmail}).then((res)=>{
                console.log(res);
                let tabValue = "1";
                this.dispatchEvent(new CustomEvent("tabvaluechange",{detail:tabValue}));
            })
        }
        

        nameEl.reportValidity();
        emaiEl.reportValidity();
        pwd.reportValidity();
        pwd2.reportValidity();
    }

    handleLogin(event){
        let tabValue = "1";
        this.dispatchEvent(new CustomEvent("tabvaluechange",{detail:tabValue}));
    }
}