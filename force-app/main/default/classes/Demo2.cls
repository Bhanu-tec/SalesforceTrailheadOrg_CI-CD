public class Demo2 
{
 public static void Createrecord(String n)
 {
     Account a = new Account();
     a.Name=n;
     insert a;
     System.debug('Account: '+a.Name);
     
     Contact c = new Contact();
     c.Lastname='Dinesh';
     c.AccountId=a.Id;
     insert c;
     System.debug('Contact: '+c.Lastname);
     
     Opportunity opp = new Opportunity();
     opp.Name='Test Opportunity';
     Date d =Date.newInstance(2022,1,31);
     opp.CloseDate=d;
     opp.StageName='CloseDate';
     opp.AccountId=a.id;
     
     insert opp;
     
     System.debug('Opportunity: '+opp.Name);
 }
}