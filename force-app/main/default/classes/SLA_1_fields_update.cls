global class SLA_1_fields_update implements  Schedulable, Database.Batchable<sObject>
{
   global Database.QueryLocator start(Database.BatchableContext BC)
   {
       String query = 'SELECT SLA1_currentElapTime__c FROM Project_Defect__c WHERE SLA1_isActive__c=True';
       System.debug('query::'+query);
       return Database.getQueryLocator(query);
   }
    
    global void execute(Database.BatchableContext BC, List<Project_Defect__c> def)
    {
        List<Project_Defect__c> pdToUpdateList = new List<Project_Defect__c>();
       for(Project_Defect__c pd : def)
       {
           
           pd.SLA1_currentElapTime__c = System.Datetime.now();
           pdToUpdateList.add(pd);   
       } 
        System.debug('ADD pdToUpdateList::'+pdToUpdateList);
        Update pdToUpdateList;
        System.debug('Update pdToUpdateList::'+pdToUpdateList);
        
        
    }
       global void finish(Database.BatchableContext BC){
       }
    
    global void execute(SchedulableContext SC){
        SLA_1_fields_update sf = new SLA_1_fields_update();
        
        String schedule00 = '10 15 * * *';
        String schedule10 = '0 10 * * * ?';
        String schedule20 = '0 20 * * * ?';
        String schedule30 = '0 30 * * * ?';
        String schedule40 = '0 40 * * * ?';
        String schedule50 = '0 50 * * * ?';
        
            system.schedule('Email Handler Files Job 00', schedule00, sf);
            system.schedule('Email Handler Files Job 10', schedule10, sf);
            system.schedule('Email Handler Files Job 20', schedule20, sf);
            system.schedule('Email Handler Files Job 30', schedule30, sf);
            system.schedule('Email Handler Files Job 40', schedule40, sf);
            system.schedule('Email Handler Files Job 50', schedule50, sf);
        
    }
         
}