public with sharing class PieChartApex 
{
   public List<position__c> lstPos;
   public List<wrapper> lstWrap{get;set;}
   
   public PieChartApex()
   {
     lstWrap= new List<wrapper>();
     lstPos= [select Name,Max_Pay__c from position__c];
        
        for(Integer i=0;i<lstPos.size();i++)
        {
           lstWrap.add(new wrapper(lstPos[i].Name,lstPos[i].Max_Pay__c));
        }
   }
   
   public class wrapper
   {
       public String PosName{get;set;}
       public Decimal Amount{get;set;}
       
       public wrapper(String pName,Decimal pAmount)
       {
           PosName=pName;
           Amount=pAmount;
       }
   }
}