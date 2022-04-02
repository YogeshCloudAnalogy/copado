({
    styleLoaded : function(component, event, helper) {
        console.log("i am in");
    },
    doInit : function(component, event, helper) {
      helper.doInitHelper(component,event)
    },

    handleSelect : function(component, event, helper){
      console.log("Id==>",event.getParam("id"));
      component.set("v.selectedId",event.getParam("id"));
    },
    getAccessToken : function(component, event, helper) {
      // helper.doInitHelper(component,event)
      helper.getCode(component,event);
    },

    getAllContacts : function(component, event, helper){
      helper.getAllContactsHelper(component, event);
    },

    createDocument : function(component, event, helper){
      let allValid = component.find('doc').reduce(function (validSoFar, inputCmp) {
                                                      inputCmp.reportValidity();
                                                      return validSoFar && inputCmp.checkValidity();
                                                  }, true);
      console.log("allValid:::",allValid);
      if(allValid){
        helper.createDocumentHelper(component,event);
      }
    },


    closeToast : function(componenet, event, helper){
      componenet.set("v.isShowToast",false);
    }

})