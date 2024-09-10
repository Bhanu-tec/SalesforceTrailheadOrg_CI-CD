trigger ContactAction on Contact (before insert) 
{
    if(trigger.isAfter && trigger.isUpdate)
    {
        ContactTriggerHandler.createCase(trigger.newMap,trigger.oldMap);
    }
    if(trigger.isBefore && trigger.isDelete)
    {
        ContactTriggerHandler.preventDeletePrimaryContact(trigger.old);
    }
    if(trigger.isBefore && trigger.isInsert)
    {
        ContactTriggerHandler.preventCreatePrimaryContactOnInsert(trigger.new);
    }
    if(trigger.isBefore && trigger.isUpdate)
    {
        ContactTriggerHandler.preventPrimaryContactonUpdate(trigger.newMap,trigger.oldMap);
    }
}