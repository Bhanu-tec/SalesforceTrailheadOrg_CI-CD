public with sharing class SearchLimtApex
{ 
  public Integer num{get;set;}
  public List<Candidate__c> canList{get;set;}
  public Boolean display{get;set;}
  public Boolean showButton{get;set;}
  
  
  public SearchLimtApex()
  {
    num=5;
    display=false;
    showButton=false;
  }
    public PageReference Hide() {
    display=false;
        return null;
    }


    public PageReference showAll() 
    {
     canList=[select Name,Full_Name__c,Email_id__c,Date_of_Birth__c,Phone_Number__c,Age__c from Candidate__c order by Name asc];
     display=true;
     showButton=true;
        return null;
    }

    public PageReference show()
     {
     if(num<0)
     {
     ApexPages.addmessage(new ApexPages.message(Apexpages.severity.Error,'limit cannot be negative'));
     display=false;
     showButton=false;
     }
     else
     {
     canList=[select Name,Full_Name__c,Email_id__c,Date_of_Birth__c,Phone_Number__c,Age__c from Candidate__c order by Name asc limit:num];
     display=true;
     showButton=true;
     }  
     return null;   
    }
   
}