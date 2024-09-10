trigger AccountTrigger on Account (before insert,before update,before delete, after insert,after update, after delete) 
{
    if(Trigger.isBefore){
    
        if(Trigger.isInsert){
            AccountTriggerHandler.beforeinsert(Trigger.New); 
            System.debug('Before Insert Trigger.new ==> '+Trigger.new);
        }
        if(Trigger.isUpdate){
            AccountTriggerHandler.beforeupdate(Trigger.New,Trigger.old,Trigger.newMap,Trigger.oldMap);                
            System.debug('Before update Trigger.new ==> '+Trigger.new + Trigger.old + Trigger.newMap);
        }
        if(Trigger.isDelete){
            AccountTriggerHandler.beforeinsert(Trigger.New);
            System.debug('Before update Trigger.new ==> '+Trigger.new);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTriggerHandler.afterInsert(Trigger.New);
            System.debug('After Insert Trigger.new ==> '+Trigger.new);
        }
        
        if(Trigger.isUpdate){
            AccountTriggerHandler.beforeinsert(Trigger.New);
            System.debug('Before update Trigger.new ==> '+Trigger.new);
        }
        if(Trigger.isDelete){
            AccountTriggerHandler.beforeinsert(Trigger.New);
            System.debug('Before update Trigger.new ==> '+Trigger.new);
        }
    }  
}