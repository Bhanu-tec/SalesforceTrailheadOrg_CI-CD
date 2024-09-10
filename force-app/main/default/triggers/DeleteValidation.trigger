trigger DeleteValidation on Candidate__c (before insert) 
{
Candidate__c can=Trigger.old[0];
Boolean Flag=False;    
if(can.can_delete__c==FALSE)
{
    can.addError('Failed to Delete Record !!! Deletion not allowed');
}
    else
    {
        List<Job_Applicatoin__c> jobAppList=[select Id,Name,Status__c from Job_Applicatoin__c where Candidate_Number__c =: can.Id];
        
        for(Job_Applicatoin__c j:jobAppList)
        {
            if(j.Status__c!='Rejected')
            {
                Flag = true;
                break;
            }
        }
        if(Flag==true)
        {
            can.addError('Cannot Delete Record!! Active Job Application Found');
        }
        else
        {
            delete jobAppList;
        }
    }
}