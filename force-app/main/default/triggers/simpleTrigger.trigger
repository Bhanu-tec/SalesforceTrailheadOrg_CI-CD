trigger simpleTrigger on Account (after insert) 
{
    List<Account> newlist = new List<Account>();
    List<Contact> lstContact = new List<Contact>();
    
    for(Account ac : trigger.new)
    {
        if(ac.No_of_Contacts__c>0)
        {
            for(Integer i=1 ; i<=ac.No_of_Contacts__c;i++)
            {
               Contact con = new Contact();
               con.AccountId = ac.id;
               con.LastName = ac.Name + i;
                con.CleanStatus = ac.Type;
               lstContact.add(con);
           }
         }
    }
    if(lstContact.size()>0)
    {
        insert lstContact;
    }
}