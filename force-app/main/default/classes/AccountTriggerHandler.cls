public class AccountTriggerHandler {
    public static void beforeinsert(List<Account> newList)
    {
        System.debug('before insert newList ==> '+newList);
     for(Account ac : newList)
    { 
        if(ac.Industry != null && ac.Industry == 'Media')
        {
        ac.Rating = 'Hot';
        ac.Description = 'New Trigger';
        }
    }
        System.debug('before insert after modifide newList ==> '+newList);
    }
    public static void beforeupdate(List<Account> newList,List<Account> oldList,Map<Id,Account> newAccMap,Map<Id,Account> oldmap){}
    public static void beforedelete(List<Account> newList){}
    public static void afterInsert(List<Account> newList)
    {
        System.debug('after insert newList ==> '+newList);
        System.debug('after insert newList Size ==> '+newList.size());
        List<Opportunity> opptoinsert = new List<Opportunity>();
        for(Account ac: newList)
        {
            Opportunity opp = new Opportunity();
            opp.Name = ac.Name;
            opp.AccountId =ac.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opptoinsert.add(opp);
        }
        if(!opptoinsert.isEmpty())
            insert opptoinsert;
            
    }
    public static void afterupdate(List<Account> newList,List<Account> oldList,Map<Id,Account> newAccMap){}
    public static void afterdelete(List<Account> newList){}

}