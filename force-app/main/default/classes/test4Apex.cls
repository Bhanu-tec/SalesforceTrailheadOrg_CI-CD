public with sharing class test4Apex
{
  
  public Candidate__c can{get;set;}
  
  public test4Apex()
  {
  can=new Candidate__c();
  }
  
  public PageReference save()
  {
  if (can.Email_id__c==''||can.Email_id__c==null)
  {
  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Email id is not filled'));
  return null;
  }
  else{
   insert can;
   PageReference pr = new PageReference('/apex/test2?id=+can.id');
  
   //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'Record Saved Successfully'));
   //can=new Candidate__c();
    return pr;
  }
  }
  
}