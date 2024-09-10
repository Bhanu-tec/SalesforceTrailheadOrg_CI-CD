public with sharing class LineChartApex 
{
public List<position__c> lstPos{get;set;}
public LineChartApex()
{
lstPos=[select Name,Max_pay__c from position__c order by Max_pay__c desc];
}
}