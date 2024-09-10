trigger acountTrigger on Account (before insert) 
{
    if(trigger.isBefore && trigger.isInsert){
        accontHandler.insertAcc(trigger.new);
    }
    
}