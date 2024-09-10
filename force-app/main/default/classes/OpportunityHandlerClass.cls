public class OpportunityHandlerClass {
    public static void afterIsert(List<Opportunity> listOpp){
         Set<Id> accIdSet = new Set<Id>();
        for(Opportunity opp : listOpp){ 
            if(opp.StageName == 'Closed Won'){
				accIdSet.add(opp.AccountId);                
            }
        }
         if(accIdSet.size()>0){
            List<Account> accList = [SELECT id, name FROM Account WHERE Id IN : accIdSet];
            if(accList.size()>0){
                delete accList; // deleting account here, associated contact will be deleted automatically.
            }
         }
    }
}