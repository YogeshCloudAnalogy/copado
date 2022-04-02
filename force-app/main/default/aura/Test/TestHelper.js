({
    getData : function(component) {
        
         var action = component.get('c.getRelatedList');
        action.setParams    
           ({
            recordId: component.get("v.recordId")
           });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let records = response.getReturnValue();
                records.forEach(cur=>{
                    cur.URL = '/'+cur.Id;
                })
                component.set('v.ContactList',records);
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    }
})