({
 myAction : function(component, event, helper) {
    component.set('v.columns', [
 {label: 'Contact', fieldName: 'URL', type: 'url',  typeAttributes: {  label: {fieldName: 'Name' },target: '_blank'  },  sortable: true },
       {label: 'Job Title', fieldName: 'Title', type: 'text'},       
     {label: 'Last Activity Date', fieldName: 'LastActivityDate', type: 'date-local', typeAttributes:  {year: 'numeric', month: 'short', day: 'numeric'}},        
         ]);
         helper.getData(component);
 }
})