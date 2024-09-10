public class BatchApexErrorEventTriggerHandler {
    public static void handleBatchErrorEvents(List<BatchApexErrorEvent> batchErrorList){
        List<Error_Log__c> errorLogList = new List<Error_Log__c>();
        
        for(BatchApexErrorEvent ev: batchErrorList){
            Error_Log__c log = new Error_Log__c ();
            log.Name = 'Batch Error';
            log.Async_Apex_Job_Id__c = ev.AsyncApexJobId;
            log.Message__c = ev.Message;
            errorLogList.add(log);
        }
        
        if(!errorLogList.isEmpty()){
            insert errorLogList;
        }
    }

}