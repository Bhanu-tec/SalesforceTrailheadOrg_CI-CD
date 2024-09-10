trigger AccountAction on Account (after insert, after update) 
{
    if(Trigger.isInsert && Trigger.isAfter)
    {
        AcountAction.createaction(Trigger.new);
    }
    
    if(Trigger.isUpdate && Trigger.isAfter)
    {
        AcountAction.createOpp(Trigger.newMap, Trigger.oldMap);
    }

}