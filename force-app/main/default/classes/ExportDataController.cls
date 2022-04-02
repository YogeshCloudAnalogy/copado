public with sharing class ExportDataController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountDataToExport(){
        List<Contact> lstContacts = [SELECT Id, LastName FROM Contact LIMIT 10000];
        return lstContacts;
    }
     @AuraEnabled
    public static Attachment generatePDF(String txtValue){
        System.debug('txtValue:::::'+txtValue);
        Pagereference pg = Page.renderAsPDF;
        pg.getParameters().put('displayText', txtValue);

        Contact con = new Contact(Id='0035g00000TzpErAAJ');
        Attachment objAttachment = new Attachment();
        objAttachment.Name = 'J2S.pdf';
        objAttachment.ParentId = con.Id;
        objAttachment.Body = pg.getContentaspdf();   
        objAttachment.IsPrivate = false;
        insert objAttachment;
        return objAttachment;
    }
}