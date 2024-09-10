trigger CaseTrigger on Case (before insert) 
{
    casehandler.sys(Trigger.New);
}