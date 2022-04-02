public with sharing class DisplayPDFController {

    public String displayText {get; set;}
    public DisplayPDFController() {
        displayText = String.escapeSingleQuotes(
            ApexPages.currentPage().getParameters().get('displayText'));
    }
}