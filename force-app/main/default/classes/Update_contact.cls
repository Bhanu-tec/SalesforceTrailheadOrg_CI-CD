public class Update_contact 
{
    public static void UpdateContact(String Name)
    {
      List<Contact> acc=[select FirstName from Contact Where Account.Name = 'United Oil & Gas, Singapore'];
       
      for(Contact ac : acc)
       {
           ac.LastName = Name;
           upsert ac;
           System.debug(ac);
       }
        
    }

}