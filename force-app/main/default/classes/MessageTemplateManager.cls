@RestResource(urlMapping='/MessageTemplate/*')
global with sharing class MessageTemplateManager {
   @HttpGet
   global static String getMessageTemplateData(){
       List<Contact> cnList = [SELECT Id,LastName FROM Contact Limit 100];
       List<Account> accList = [SELECT Id, Name FROM Account Limit 100];
       return JSON.serialize( new Map<String,Object>{
        'Contact'=>JSON.serialize(cnList),
        'Account'=>JSON.serialize(accList)
    });
   }
}