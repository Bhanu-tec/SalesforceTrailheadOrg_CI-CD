public with sharing class AssingchartApex 
{
  public List<position__c> pos{get;set;}
  
  public AssingchartApex()
  {
    pos=[SELECT Close_Date__c,Open_Date__c FROM position__c ORDER BY Open_Date__c ASC];
  }
}