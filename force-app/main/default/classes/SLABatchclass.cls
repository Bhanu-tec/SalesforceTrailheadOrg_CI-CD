global class SLABatchclass implements  Database.Batchable<sObject>
{
   global Database.QueryLocator start(Database.BatchableContext BC)
   {
       String query = 'SELECT  FROM Project_Defect__c WHERE SLA1_isActive__c=True';
       return Database.getQueryLocator(query);
   }
    
    global void execute(Database.BatchableContext BC, List<Project_Defect__c> def)
    {
        List<Project_Defect__c> pdToUpdateList = new List<Project_Defect__c>();
       for(Project_Defect__c pd : def)
       {    
           pd.ctme__c = 90;
           pdToUpdateList.add(pd);   
       } 
        Update pdToUpdateList;   
    }
       global void finish(Database.BatchableContext BC){
        Datetime dt = system.now();
        String day = string.valueOf(dt.day());
        String month = string.valueOf(dt.month());
        String hour = string.valueOf(dt.hour());
        String minute = string.valueOf(dt.minute());
        String second = '00';
        String year = string.valueOf(system.now().year());
        String strJobName = 'SampleSchedulingClass1  -' + year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
        //String strSchedule = '00 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
        System.schedule(strJobName, '0 0 * ? * MON-FRI *', new SLASchedulableClass());
       }         
}