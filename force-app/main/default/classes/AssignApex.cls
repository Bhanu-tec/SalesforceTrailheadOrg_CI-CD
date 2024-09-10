public with sharing class AssignApex
{
 public String CandEmail{get;set;}
 public Candidate__c can{get;set;}
 
     public PageReference search() 
     {
      PageReference pr = new PageReference('/apex/AssignPagRef?CEmail='+CandEmail);
        return pr;
     }

}