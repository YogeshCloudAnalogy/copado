public with sharing class KeyContactsInHierarchyController 
{
   @AuraEnabled
    public static list<Contact> getRelatedList(Id recordId){
       
       
        List<Contact> Conlist = [Select id, name,firstname,lastname, title, LastActivityDate from Contact];
        return Conlist;
    }
}