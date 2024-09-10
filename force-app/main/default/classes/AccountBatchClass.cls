public class AccountBatchClass implements  Database.Batchable<sObject>
{
   public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([select Id,Name from Account]);
    }

    public void execute(Database.BatchableContext context, List<Account> acct) {
       List<Account> acc1 = new List<Account>();

    for(Account acc : acct)
    { 
      List<AggregateResult>  cnt = [SELECT COUNT(Id) countTask FROM CONTACT WHERE Contact.AccountId =: acc.id];  
      Integer tskCount = (Integer)cnt[0].get('countTask'); 
      acc.No_of_Contacts__c = tskCount;
      acc1 .add(acc);
    }
        update acc1;
    }
    public void finish(Database.BatchableContext BC){
        
    }         
}