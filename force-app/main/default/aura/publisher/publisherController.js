({
    handleClick : function(component, event, helper) {
        event.preventDefault();
        let paylod = {
            recordId : "this is recordId",
            recordData : "this is record Data"
        }
        console.log(paylod);
        console.log(component.find("sampleMessageChannel"));
        component.find("sampleMessageChannel").publish(paylod);
    }
})