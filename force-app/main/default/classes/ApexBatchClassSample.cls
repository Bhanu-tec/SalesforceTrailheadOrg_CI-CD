global class ApexBatchClassSample implements Database.Batchable<sObject>
{
  global Database.QueryLocator start(Database.BatchableContext Bc)
  {
      String query= 'select Name,type from Account';
      return Database.getQueryLocator(query);
  }
    global void execute(Database.BatchableContext Bc,List<Account> lstAcc)
    {
        for(Account a:lstAcc)
        {
            a.Name=a.Name+'-Update';
        }
        update lstAcc;
    }
    global void finish(Database.BatchableContext Bc)
    {}
}