public with sharing class canpagrefApex
{
  public String canEmail{get;set;}
  
  public Candidate__c can{get;set;}
  
  public canpagrefApex()
  {
  canEmail=apexPages.currentPage().getParameters().get('cEmail');
  can=[select Name,Full_Name__c,Email_id__c,Date_of_Birth__c,Phone_Number__c,Age__c from Candidate__c where Email_id__c=: canEmail];
  }

}