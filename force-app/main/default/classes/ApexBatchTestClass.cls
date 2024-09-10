@isTest
private class ApexBatchTestClass 
{
     static testMethod void validate()
     {
         List<Account> lstAcc=new List<Account>();
         
         for(Integer i=0;i<100;i++)
         {
             
             Account acc=new Account(Name='Account'+i);
             lstAcc.add(acc);
         }
         
         insert lstAcc;
         
         test.startTest();
            ApexBatchClassSample b= new ApexBatchClassSample();
         Database.executeBatch(b);
         test.stopTest();
     }

}