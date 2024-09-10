trigger OpportunityAfterInsert on Opportunity (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        OpportunityHandlerClass.afterIsert(trigger.new);
    }
}