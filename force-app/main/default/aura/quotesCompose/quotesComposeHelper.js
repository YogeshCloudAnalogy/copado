({
getSelectedItem: function(cmp, event) {
var clicked = event.currentTarget;
var parent = clicked.parentElement;
var total = parent.children.length;
var selectedIndex = -1;
for(var i=0; i<total; i++) {
if(clicked === parent.children.item(i)) {
selectedIndex = i;
}
$A.util.removeClass(parent.children.item(i), "selected");
}
$A.util.addClass(clicked, "selected");
var selectedTh = cmp.get("v.items")[selectedIndex];
return selectedTh;
},
getPayload: function(item) {
return item;
},
getTitle: function(item) {
return item.title;
},
getDescription: function(item) {
return item.caseNo;
}
})