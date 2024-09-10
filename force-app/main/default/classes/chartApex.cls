public with sharing class chartApex
{
public List<position__c> lstPos{get;set;}
public chartApex()
{
lstPos=[select Name,Max_pay__c from position__c];
}
}