public class caseController {
@AuraEnabled
public static List<Case> getCases() {
List<Case> cases = [SELECT AccountId,CaseNumber,Subject,Description,Id FROM
Case ORDER BY CreatedDate ASC NULLS FIRST LIMIT 20];
    return cases;}

}