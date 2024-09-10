public class ContactTriggerHandler 
{
    public static void createCase(Map<id,Contact> contactNewMap,Map<id,Contact> contactOldMap)
    {
        List<Case> caselist = new List<Case>();
        for(Contact contObj : contactNewMap.values())
        {
            if(contactNewMap.get(contObj.Id).LeadSource != contactOldMap.get(contObj.Id).LeadSource
              && contactNewMap.get(contObj.Id).LeadSource == 'Other')
            {
                Case caseObj = new Case();
                caseObj.Status = 'Open';
                caseObj.Priority = 'High';
                caseObj.Origin = 'Other';
                caseObj.Subject = 'Contact Created from Lead Source Other';
                caseObj.ContactId = caseObj.Id;
                caselist.add(caseObj);
            }
        }
        if(!caselist.isEmpty())
        {
            insert caselist;
        }
    }
    public static void preventDeletePrimaryContact(List<Contact> contactList)
    {
        for(Contact contObj : contactList)
        {
            if(contObj.IsPrimary__c)
            {
                contObj.addError('Primary Contact Cannot be Deleted');
            }
        }
    }
    //Starting of logic to prevent user to create primary contact if there is any existing primary contact under account
    public static void preventCreatePrimaryContactOnInsert(List<Contact> contactList)
    {
        Set<id> accountIdSet = new Set<id>();
        Map<Id,Contact> accountIdContactMap = new Map<Id,Contact>();
        
        for(Contact contactObj : contactList)
        {
            if(contactObj.IsPrimary__c == true && contactObj.AccountID != null)
            {
                accountIdSet.add(contactObj.AccountID);
            }
        }
        if(accountIdSet != null && accountIdSet.size()>0)
        {
            //preparation of map accountIdContactMap for existing primary contact 
            for(Contact contObj : [Select id,IsPrimary__c,AccountId from Contact
                                  where AccountId in : accountIdSet])
            {
                accountIdContactMap.put(contObj.AccountId,contObj);
            }
            //validation starts
            for(Contact contactObj : contactList)
            {
                if(contactObj.IsPrimary__c == true && contactObj.AccountId != null
                  && accountIdContactMap.get(contactObj.AccountId)!=null)
                {
                    contactObj.addError('You Can\'t Create More Than One Primary Contact');
                }
            }
        }
    }
    
    public static void preventPrimaryContactonUpdate(Map<id,Contact> contactNewMap,Map<id,Contact> contactOldMap)
    {
        Set<id> accountIdSet = new Set<id>();
        Map<Id,Contact> accountIdContactMap = new Map<Id,Contact>();
        for(Contact contactObj : contactNewMap.values())
        {
            if(contactNewMap.get(contactObj.Id).IsPrimary__c != contactOldMap.get(contactObj.Id).IsPrimary__c
              && contactNewMap.get(contactObj.Id).IsPrimary__c == true 
               && contactNewMap.get(contactObj.Id).AccountId != null)
            {
                accountIdSet.add(contactNewMap.get(contactObj.id).AccountID);
            }
        }
        if(accountIdSet != null && accountIdSet.size()>0)
        {
            //preparation of map accountIdContactMap for existing primary contact 
            for(Contact contObj : [Select id,IsPrimary__c,AccountId from Contact
                                  where AccountId in : accountIdSet and IsPrimary__c = true])
            {
                accountIdContactMap.put(contObj.AccountId,contObj);
            }
            //validation starts
            for(Contact contactObj : contactNewMap.values())
            {
                if(contactNewMap.get(contactObj.Id).IsPrimary__c != contactOldMap.get(contactObj.Id).IsPrimary__c
                   && contactNewMap.get(contactObj.Id).IsPrimary__c == true 
                   && contactNewMap.get(contactObj.Id).AccountId != null
                   && accountIdContactMap.get(contactNewMap.get(contactObj.Id).AccountId)!=null)
                {
                    contactObj.addError('You Can\'t Make More Than One Contact as Primary');               
                }
            }
        }
    }
}