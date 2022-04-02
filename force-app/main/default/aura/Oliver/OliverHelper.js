({
    doInitHelper : function(component,event) {
        var url = window.location.href;
      function getParameterByName(name, url) {
           if (!url) url = window.location.href;
           name = name.replace(/[\[\]]/g, '\\$&');
           var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
               results = regex.exec(url);
           console.log('===results==',results);
           if (!results) return null;
           if (!results[2]) return '';
           return decodeURIComponent(results[2].replace(/\+/g, ' '));
       }
      var code = getParameterByName('code');
       console.log("code",code);
       this.checkForAccessToken(component,event);
       if(code &&  !component.get("v.isContainAccessToken")){
         this.doGetAccessTokenFromGoogle(component,event,code);
       }
    },
    getCode : function(component,event){
        let action  =  component.get("c.createAuthURL");
        action.setCallback(this,(response)=>{
            console.log(response.getReturnValue());
            window.location.href = response.getReturnValue();
        })
        $A.enqueueAction(action);
    },

    doGetAccessTokenFromGoogle : function(component, event, code){
        let action = component.get("c.doGetAccessToken");
        action.setParams({"code":code});
        action.setCallback(this,function(res){
            if(res.getState() === "SUCCESS"){
                component.set("v.isContainAccessToken",res.getReturnValue());
            }
        })
        $A.enqueueAction(action);
    },

    getAllContactsHelper : function(component, event){
    
        if(!component.get("v.isContainAccessToken")){
           console.log()
        }else{
            let action = component.get("c.getContacts");
            action.setCallback(this,(res)=>{
                let state = res.getState();
                if(state == "SUCCESS"){
                    console.log(res.getReturnValue());
                    component.set("v.contactList",JSON.parse(res.getReturnValue()));
                }
            });
            $A.enqueueAction(action);
        }

    },

    checkForAccessToken : function(component, event){
        let action = component.get("c.checkAccessToken");
        action.setCallback(this,res=>{
            if(res.getState()=="SUCCESS"){
                component.set("v.isContainAccessToken",res.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    },

    createDocumentHelper: function(component, event){
    
        let action = component.get("c.createDoc");
        action.setParams({
            "title":component.get("v.docTitle"),
            "textContent":component.get("v.text")
        })
        action.setCallback(this,(res)=>{
            let state = res.getState();
            if(state == "SUCCESS"){
                component.set("v.docTitle",'');
                component.set("v.text",'');
                component.set("v.isShowToast",res.getReturnValue());
                window.setTimeout(
                    $A.getCallback(function() {
                        component.set("v.isShowToast", false);
                    }), 5000
                );

            }
        });
        $A.enqueueAction(action);

    },

})