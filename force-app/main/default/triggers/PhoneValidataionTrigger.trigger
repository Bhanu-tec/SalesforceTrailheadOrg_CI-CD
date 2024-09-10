trigger PhoneValidataionTrigger on Candidate__c (before insert,before update) 
{
    Candidate__c can=Trigger.New[0];
    if(can.Phone_Number__c==''||can.Phone_Number__c==null)
    {
        can.addError('Phone number Cannot be left');
    }
}