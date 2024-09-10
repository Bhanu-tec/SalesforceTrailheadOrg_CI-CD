public class Demo 
{
 Public void CreateAccount(String Name, String Phone)
 {
        account acc=new account();
       
        acc.Name=Name;
       
        acc.phone=Phone;
       
        insert acc;
       
        System.debug('Account Inserted :'+acc.Name);
        System.debug('Account Inserted :'+acc.phone);
        
    }
}