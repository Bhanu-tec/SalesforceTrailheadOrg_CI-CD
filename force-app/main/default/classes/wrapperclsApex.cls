public with sharing class wrapperclsApex 
{
       public list<wrapper> lstwrap{get;set;}
       public list<position__c> lstPos;
       public list<Candidate__c> lstCan;
       public Integer count;

    public wrapperclsApex()
    {
      count=0;
      lstwrap=new List<wrapper>();
      
      lstPos=[select Name,Status__c from position__c limit:5];
      lstCan=[select Full_Name__c,Email_id__c from Candidate__c limit:5];
     
      for(Integer i=0;i<lstPos.size();i++)
      {
         lstwrap.add(new wrapper(lstPos[i],lstCan[i],++count));
      
      }
    
    }
    

    public class wrapper
    {
         public position__c Pos{get;set;}
         public Candidate__c Can{get;set;}
         public Integer num{get;set;}
         
         public wrapper(position__c pos1, Candidate__c can1, Integer num1)
         {
           Pos=pos1;
           Can=can1;
           num=num1;
         }
    }
}