public without sharing class AccountToUserIdList {

/*
Invoc method will accept a list of account ids and return a 
list of user ids, whose contacts are associated with the input list's accounts
*/


    @InvocableMethod
    public static List<FlowOutput> runClass(List<FlowInput> inputAccountIds){

        List<FlowOutput> outputList = new List<FlowOutput>();

        List<String> accountIds = new List<String>();
        List<String> contactIds = new List<String>();
        List<String> userIds = new List<String>();



        for(FlowInput input : inputAccountIds){

            system.debug('*** Running through input...');
            

            for(String currentString : input.accountIdsList){
                accountIds.add(currentString);
            }
        }


        contactIds = getContactIds(accountIds);

        userIds = getUserIds(contactIds);


        FlowOutput newOutput = new FlowOutput();

        for(String id : userIds){            

         //   newOutput.userId = id;

            newOutput.userIdsListOutput = new List<string>{id};

         

        }

        outputList.add(newOutput);


        return outputList;

    }



    public static List<String> getContactIds(List<String> inputAccountIds){

        List<String> returnList = new List<String>();

        system.debug('*** Searching for Contacts from input Account Ids');

        for(Contact c : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :inputAccountIds]){
            returnList.add(c.Id);
        }

        system.debug('Found these Contacts ' + returnList);

        return returnList;

    }


    public static List<String> getUserIds(List<String> inputContactIds){

        List<String> returnList = new List<String>();

        system.debug('*** Searching for Users from input Contact Ids');


        for(User u : [SELECT Id, ContactId FROM User]){
            returnList.add(u.Id);
        }

        system.debug('Found these Users ' + returnList);


        return returnList;


    }


    public class FlowInput{

        @InvocableVariable
        public String accountId;


        @InvocableVariable
        public List<String> accountIdsList;

    }


    public class FlowOutput{

        @InvocableVariable
        public String userId;


        @InvocableVariable
        public List<String> userIdsListOutput;

    }

}