public class CallCreateNewContactTrigger {
    public Static void CreateContactMethod(List<Account> accList){
        List<Contact> conList= new List<Contact>();
        for(Account ac : accList){
            contact cc = new contact();
            cc.Lastname = ac.name;   
            cc.Id = ac.Id;
            conList.add(cc);
        }
        insert conList;
    }
}