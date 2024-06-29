global class PilotRatingBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //Intentionally skip Pilot__r.Pilot_Rating__c field from the SOQL query to force the error: SObject row was retrieved via SOQL without querying the requested field: Mission__c.Pilot__r. 
        //Do not update the SOQL query for the solution.
        return Database.getQueryLocator('SELECT Id, Completion_Rating__c, Overall_Rating__c, Safety_Incidents__c, Pilot__c FROM Mission__c WHERE Status__c = \'Complete\'');
        
    }

    global void execute(Database.BatchableContext bc, List<Mission__c> scope) {
        List<Contact> contactList = new List<Contact>();
        for(Mission__c mission : scope){
            
            Double weightedCompletionRate = 0.3 * mission.Completion_Rating__c;
            Double weightedSafetyIncidents = -0.5 * mission.Safety_Incidents__c;

            Double newOverallRating;
            
            newOverallRating = mission.Pilot__r.Pilot_Rating__c+mission.Overall_Rating__c;
            mission.Pilot__r.Pilot_Rating__c = newOverallRating;
            
            contactList.add(mission.Pilot__r);
        }
        
        update contactList;
    }

    global void finish(Database.BatchableContext bc) {
    }


}