public with sharing class SignupController {
    @AuraEnabled
    public static boolean createAccount(String userName, String email){
        // try {
            Account acc = new Account(Name=userName);
            insert acc;
            Contact cn = new Contact(LastName=userName,AccountId = acc.Id, Email = email);
            insert cn;
            createUser(userName, email, cn.Id);
            return true;
        // } catch (Exception e) {
        //     throw new AuraHandledException(e.getMessage());
        // }
    }
    @future 
    public static void createUser(String userName, String email, String conId){
        Profile pr = [SELECT Id FROM Profile WHERE Name ='Customer Community User'];
        User u = new User();
        u.LastName	  = userName;
        u.Username = userName+'_'+email;
        u.ProfileId = pr.Id;
        u.Alias = userName;
        u.CommunityNickname = userName;
        u.LocaleSidKey = 'en_US';
        u.TimeZoneSidKey = 'GMT';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.IsActive = true;
        u.ContactId = conId;
        u.Email = email;
        insert u;
        

    }
}