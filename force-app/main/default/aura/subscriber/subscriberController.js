({
    handleMessage : function(component, message) {
        alert("i am here");
        console.log("message"+JSON.stringify(message.getParams()));
    }
})