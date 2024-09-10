trigger DLPTrigger on DLP__c (before Update) 
{
 if(trigger.isBefore && trigger.isUpdate)
    {
        CalculateBH.WorkingHours(Trigger.new);
    }

}