public with sharing class WorkOrderListItemTriggerHandler {
public static String userProfileName = [select Name from profile where id =: userinfo.getProfileId()].Name;
    public static void onBeforeDelete(List<WorkOrderLineItem> workItemlist){
        //List<WorkOrder> wolist = [Select Status, WorkOrderNumber From WorkOrder];
        //Map<Id, WorkOrderLineItem> deletedLineItems = (Map<Id, WorkOrderLineItem>)Trigger.oldMap;
      
        Set<String> workOrderNumbersSet = new Set<String>();
        for(WorkOrderLineItem lineitem : workItemlist){
            workOrderNumbersSet.add(lineItem.WorkOrder.WorkOrderNumber);
            system.debug('workOrderNumber:::'+lineItem.WorkOrder.WorkOrderNumber);
            System.debug('workOrderNumbersSet ::' +workOrderNumbersSet);
            if(lineitem.Tech_undeletable__c && userProfileName == 'System Administrator'){
                    lineitem.addError('You cannot delete these labor lines');
            }
            List<WorkOrder> wolist = [Select Status, WorkOrderNumber From WorkOrder where WorkOrderNumber IN :workOrderNumbersSet];
        	System.debug('Wolist ::'+ workOrderNumbersSet);
            for(WorkOrder wo : wolist){
            	if(userProfileName == 'System Administrator' && (wo.Status == 'Closed' || wo.Status == 'Canceled')){
                	lineitem.addError('You cannot delete these labor lines');
            	}
        	}
        }   
    }
    
public static void onBeforeUpdate(List<WorkOrderLineItem> newLineItems, Map<Id,WorkOrderLineItem> oldLineItemsMap) {
    List<WorkOrderLineItem> invalidLineItems = new List<WorkOrderLineItem>();
    List<WorkOrderLineItem> validLineItems = new List<WorkOrderLineItem>();
    for (WorkOrderLineItem newLineItem : newLineItems) {
        WorkOrderLineItem oldLineItem = oldLineItemsMap.get(newLineItem.Id);
        if (oldLineItem.WorkOrder.Status == 'Closed' && userProfileName == 'System Administrator') {
            invalidLineItems.add(newLineItem);
        }
    }
    if (!invalidLineItems.isEmpty()) {
        for(WorkOrderLineItem newLineItem : newLineItems) {
            Boolean isInvalid = false;
            for(WorkOrderLineItem invalidLineItem : invalidLineItems) {
                if(newLineItem.Id == invalidLineItem.Id) {
                    isInvalid = true;
                    break;
                }
            }
            if(!isInvalid) {
                validLineItems.add(newLineItem);
            }
        }
        newLineItems = validLineItems;
        throw new System.DmlException('Error: Only Admin can edit WorkOrderLineItem records when the associated WorkOrder is closed.');
    }
}


    
    public static void onBeforeInsert(List<WorkOrderLineItem> workItemlist){
        
        //List<WorkOrderLineItem> lineItemsToinsert = new List<WorkOrderLineItem>();
        for(WorkOrderLineItem lineitem : workItemlist){
            
            if(userProfileName == 'System Administrator' && (lineitem.WorkOrder.Status == 'Canceled' || lineitem.WorkOrder.Status == 'Closed')){
                //system.debug('3.'+userInfo.getUserName());
                lineitem.addError('You are not allowed to Insert this record');
            }
        }
    }  
}