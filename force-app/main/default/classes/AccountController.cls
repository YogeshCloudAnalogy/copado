public with sharing class AccountController {
   @AuraEnabled
   public static List<Account> getAccountAddress(){
       try {
           return [SELECT ShippingStreet,ShippingState,ShippingCountry FROM Account WHERE ShippingCountry != null LIMIT 100];
       } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
}
