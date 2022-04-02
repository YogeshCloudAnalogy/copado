public with sharing class HB_BS_UserController {
    public User user {get;set;} 
    public HB_BS_UserController(ApexPages.StandardController stdController) {
        this.user = (User)stdController.getRecord();
        System.debug(this.user.Id); // returns null 
    }

    public String getUserNameMessage(){
        return 'This is the userName = ' + this.user.FirstName; // value here is null. 
    }
}