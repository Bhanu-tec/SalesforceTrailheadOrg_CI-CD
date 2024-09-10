@isTest
public class AccountBatchTestClass{
    @isTest
    static void testprocess(){
        
        Account ac = new Account();
		contact con = new contact();
        ac.id = con.AccountId;
        ac.Name = 'Test';
        ac.Name = con.FirstName;
        ac.Name = con.LastName;
        insert ac;
        
        Test.startTest();
        Database.executeBatch(new AccountBatchClass());
        Test.stopTest();
    }
}