trigger WorkOrderListItemTrigger on WorkOrderLineItem (before insert, before update, before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        WorkOrderListItemTriggerHandler.onBeforeDelete(Trigger.old);
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        WorkOrderListItemTriggerHandler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    else if(Trigger.isBefore && Trigger.isInsert){
        WorkOrderListItemTriggerHandler.onBeforeInsert(Trigger.new);
    }
}