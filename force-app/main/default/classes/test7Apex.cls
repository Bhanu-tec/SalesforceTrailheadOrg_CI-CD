public with sharing class test7Apex
{
  public String canEmail{get;set;}
  
  public test7Apex()
  {
  canEmail='bhanu2919109@gmail.com';
  }
   public PageReference search()
   {
   PageReference pr = new PageReference('/apex/canpagref?cEmail='+canEmail);
        return pr;
   }

}