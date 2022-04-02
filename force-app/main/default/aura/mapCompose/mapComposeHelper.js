({
    getAccountAddress : function(component,event,helper) {
        let action = component.get('c.getAccountAddress');
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                console.log(response.getReturnValue());
                component.set("v.accList",response.getReturnValue());
            }
        })
        $A.enqueueAction(action);
    }
})
