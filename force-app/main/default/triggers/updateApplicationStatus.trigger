trigger updateApplicationStatus on Job_Applicatoin__c (After insert,after Update) {
    List<Job_Applicatoin__c>  japp = new List<Job_Applicatoin__c>();
    for(Job_Applicatoin__c ja : trigger.new)
    {
        if(ja.Review_Count__c>=3){
           ja.Status__c = 'Extend Offer';  
        }
        japp.add(ja);
    }
    update japp;
}