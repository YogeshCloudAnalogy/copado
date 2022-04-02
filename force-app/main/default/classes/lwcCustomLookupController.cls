public with sharing class lwcCustomLookupController {
   @AuraEnabled(cacheable=false)
   public static string getResults(String  ObjectName,String fieldName,String value){
    //    try {
           String query = 'SELECT '+ fieldName +' FROM '+ ObjectName+' WHERE '+fieldName+' LIKE \''+value+'%\' LIMIT 4';
           System.debug('query:::'+query);
           System.debug(Database.query(query));
           return JSON.serialize(Database.query(query));
    //    } catch (Exception e) {
    //        throw new AuraHandledException(e.getMessage());
    //    }
   }
}