public class CSVController  {

    @AuraEnabled
    public static void loadCSVData(List<Id> contentDocumentIds) {
        System.debug('contentDocumentIds => ' + contentDocumentIds);

        List<ContentVersion> contentVersionList = [SELECT Id, VersionData, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN :contentDocumentIds];
        System.debug('contentVersionList => ' + contentVersionList);

        // Process the contentVersionList as needed
    }
}