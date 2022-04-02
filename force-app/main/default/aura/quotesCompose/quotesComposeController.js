({
    init : function(cmp, event, helper) {
        var action = cmp.get("c.getCases");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var caseList = [];
                var response = response.getReturnValue();
                for (var i=0;i<response.length;i++) {
                    caseList.push({
                        "title": response[i].Subject,
                        "caseNo": response[i].CaseNumber
                    })
                }
                cmp.set("v.items", caseList);
            }
        });
        $A.enqueueAction(action);
    },
    selected: function(cmp, event, helper) {
        var selectedItem = helper.getSelectedItem(cmp, event);
        var compEvent = cmp.getEvent("sendChatterExtensionPayload");
        compEvent.setParams({
            "payload" : helper.getPayload(selectedItem),
            "extensionTitle" : helper.getTitle(selectedItem),
            "extensionDescription" : helper.getDescription(selectedItem)
        });
        compEvent.fire();
    }
})