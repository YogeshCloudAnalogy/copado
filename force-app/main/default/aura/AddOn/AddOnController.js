({
    doInit : function(component, event, helper) {
        let rows = [{Id:0}];
        component.set("v.rows", rows);
    },
    
    handleAddrow : function(component, event, helper) {
        let rows  = component.get("v.rows");
        const lastRow  = rows[rows.length-1];
        let newRow = {Id : lastRow.Id+1};
        rows.push(newRow);
        component.set("v.rows", rows);
    },

    handleRemoveRow :function(component, event, helper){
        console.log("hello from remove handler");
        let elId = event.target.dataset.id;
        let rows  = component.get("v.rows"); 
        if(rows.length > 1){
            let tempRows = rows.filter((cur)=>{
                return parseInt(cur.Id) != parseInt(elId)
            });
            component.set("v.rows",tempRows);
        }
        else{
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error!",
                "message": "There Should be atleast one row",
                "type":"Error"
            });
            toastEvent.fire();
        }
    } ,

    handleClick : function(component, event, helper) {
        console.log("hello");
        let rows  = component.get("v.rows");
        if(rows.length >1){
            component.find('contactForm').forEach((cur)=>{
                cur.submit();
            })
        }
        else{
            component.find('contactForm').submit();
        }
        // toastEvent.setParams({
        //     "title": "Success!",
        //     "message": "Submit Successfully",
        //     "type":"Success"
        // });
        // toastEvent.fire();
        $A.get('e.force:refreshView').fire();
    }
})