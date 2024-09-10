trigger CaseCommentTrigger on Case (before insert) 
{
   CaseTriggerHandler.com(Trigger.new);
}