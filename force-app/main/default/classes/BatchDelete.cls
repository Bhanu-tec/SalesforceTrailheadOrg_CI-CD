global class BatchDelete implements Database.Batchable<sObject> {
    
  
   global Database.QueryLocator start(Database.BatchableContext BC){
       String query = 'SELECT Id FROM Pen__c WHERE SystemModstamp >= 2022-05-08T01:02:03Z';
       return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext BC, List<sObject> def)
   {
      delete def; 
   }

   public void finish(Database.BatchableContext BC){
   }
}