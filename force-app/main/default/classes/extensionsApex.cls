public with sharing class extensionsApex {
     
    Candidate__c can;

    public extensionsApex(ApexPages.StandardController stdCtrl)
    {
        can=(Candidate__c)stdCtrl.getRecord();
    }


       public void saveRecord()
       {
          insert can;
          ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Record inserted Successfully'));
        
       }
}