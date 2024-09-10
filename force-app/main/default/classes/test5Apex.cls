public with sharing class test5Apex 
{
    public List<Candidate__c> canList{get;set;}
    
    public test5Apex()
    {
       canList=[select Name, Full_Name__c, Email_id__c, Experience__c, Date_of_birth__c, Age__c,Status__c, Phone_Number__c from Candidate__c where Age__c<30];
    }

}