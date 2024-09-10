global class SLA11Batchclass implements  Database.Batchable<sObject>,Database.AllowsCallouts,Database.stateful
{
   global Database.QueryLocator start(Database.BatchableContext BC)
   {
       String query = 'SELECT currentHours__c FROM Project_Defect__c';
       return Database.getQueryLocator(query);
   }
    
    global void execute(Database.BatchableContext BC, List<Project_Defect__c> def)
    {
        List<Project_Defect__c> pdToUpdateList = new List<Project_Defect__c>();
       for(Project_Defect__c pd : def)
       {
           
           if(pd.SLA1_isActive__c){
               Long result = BusinessHours.diff('01m5g000001TAPDAA4', pd.SLA1_currentPeriodStart__c, System.Datetime.now());
               pd.currentHours__c = result;//(60*60*1000);
           }  
           pdToUpdateList.add(pd);
       } 
        Update pdToUpdateList;   
    }
    global void finish(Database.BatchableContext BC){
        
    }         
}