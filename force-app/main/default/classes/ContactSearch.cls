public class ContactSearch {
    public static List<Contact> searchForContacts(string lastName, string mailingPostalCode)
    {
       List<Contact> l1 = [select ID,Name from Contact where LastName =: lastName and MailingPostalCode =: mailingPostalCode];
        return l1;
    }

}