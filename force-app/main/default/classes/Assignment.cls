public class Assignment 
{ 
    public static void   UpdateAccount(String name)
    {
        List<Account> acc = [Select  Name from Account Where Name ='Amruth'];
       
        for(Account a : acc)
        {
            a.Name=name;
            upsert acc;
            System.debug(acc);
        }
        
    }
}