trigger SLA_Calculation on Project_Defect__c (before update) {
    //Selecting default business hours (BH) record
    BusinessHours defaultBH = [SELECT Id FROM BusinessHours WHERE IsDefault = true Limit 1];
    
    // set of active status for SLA1
    Set<String> setActiveStatusSLA1 = new Set<String>{'New', 'Under analysis'};    
    
    // set of status with contexts (environment and workaround)
    Set<String> setStatuswithContext = new Set<String>{'Under implementation', 'Build completed','To be tested','Tested OK - to be delivered','Tested KO - to be fixed','Delivered','Close completed'};    
    
    //Making sure BH record exists
    if(defaultBH != NULL){
        for(Project_Defect__c defectObj : trigger.new ){
            
            // A. COMPUTE Status_with_contexts__c FIELD
            // By default the status with contexts is equal to Status
            defectObj.Status_with_contexts__c = defectObj.Status__c;
            
            // Status_with_contexts__c is different from Status__c only in specific cases where the contexts (environment and workaround) have to be displayed
            if(setStatuswithContext.contains(defectObj.Status__c)) {
                // the workaround context must be added when the workaround is required and has not been yet implemented
                if (defectObj.isWorkAroundRequired__c && !defectObj.isWorkAroundDone__c) {
                    defectObj.Status_with_contexts__c = 'Workaround / ' + defectObj.Status__c;    
                }
                
                // otherwise the environment is added as a prefix
                    if (defectObj.Environment_Context__c == null) {
                        defectObj.Status_with_contexts__c = '<set environment context> / ' + defectObj.Status_with_contexts__c;  
                    } 
                    else {
                        defectObj.Status_with_contexts__c = defectObj.Environment_Context__c + ' / ' + defectObj.Status_with_contexts__c;
                    }
            }
            
            // B. SLA CALCULATIONS
            
            //ENTERING AN ACTIVE STATUS FROM AN INACTIVE STATUS FOR SLA1 
            //Defect still in analysis and defect status has changed and defect status is active for SLA1 and previous defect status was not active for SLA1
            if(defectObj.isFirstReturnDone__c == false && Trigger.oldMap.get(defectObj.Id).Status__c!= defectObj.Status__c 
                && setActiveStatusSLA1.contains(defectObj.Status__c)
                && !setActiveStatusSLA1.contains(Trigger.oldMap.get(defectObj.Id).Status__c) ){
                
                //Define the start date time in GMT of the period when SLA1 is active
                defectObj.SLA1_currentPeriodStart__c = System.Datetime.now();
                
                // Setting to null end of current period (required since there can be various active periods)
                defectObj.SLA1_currentPeriodEnd__c = null;
                
                // setting to true the flag to assess whether SLA1 is active or not
                defectObj.SLA1_isActive__c = true;

            }
            
            //LEAVING A VALID STATUS FOR SLA1
            //Defect still in analysis and defect status has changed and defect status not active for SLA1
            if(defectObj.isFirstReturnDone__c == false && Trigger.oldMap.get(defectObj.Id).Status__c!= defectObj.Status__c&& !setActiveStatusSLA1.contains(defectObj.Status__c) ){
                
                // Amount of time spent in the active status for SLA1
                long result = BusinessHours.diff(defaultBH.id, defectObj.SLA1_currentPeriodStart__c, System.Datetime.now());
                
                // Result from the method is divided by 60*60*100 (milliseconds to be then converted into hours)
                //Decimal resultingHours = result/(60*60*1000);
                
                // elapsed time on this period is added up to the cumulated & past elapsed time
                defectObj.SLA1_previousElapsedTime__c = result;//defectObj.SLA1_previousElapsedTime__c + resultingHours;
                
                // Setting the end of the current period
                defectObj.SLA1_currentPeriodEnd__c = Datetime.now();
                
                // setting to false the flag to assess whether SLA1 is active or not
                defectObj.SLA1_isActive__c = false;
            }
            
            //TERMINATION OF SLA1
            //First analysis has been done for Defect
            if(Trigger.oldMap.get(defectObj.Id).isFirstReturnDone__c != defectObj.isFirstReturnDone__c && defectObj.isFirstReturnDone__c == true){
                
                // Amount of time spent in the active status for SLA1 (we assume the analysis is done during an active period for SLA1)
                Decimal result = BusinessHours.diff(defaultBH.id, defectObj.SLA1_currentPeriodStart__c, System.Datetime.now());
                
                // Result from the method is divided by 60*60*100 (milliseconds to be then converted into hours)
                Decimal resultingHours = result/(60*60*1000);
                
                // elapsed time on this period is added up to the cumulated & past elapsed time
                defectObj.SLA1_previousElapsedTime__c = defectObj.SLA1_previousElapsedTime__c + resultingHours;
                
                // Setting the end of the current period
                defectObj.SLA1_currentPeriodEnd__c = Datetime.now();
                
                // setting to false the flag to assess whether SLA1 is active or not
                defectObj.SLA1_isActive__c = false;
            }
            
            if(defectObj.SLA1_remainingTime__c <0){
                defectObj.SLA1_isBreached__c = False;
            }
            else {
                defectObj.SLA1_isBreached__c = True;
            }
            
        }    
    } 
}