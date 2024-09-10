public class accontHandler 
{
    public static void insertacc(List<Account> acc){
     
    for(Account ac: acc)
    {
        ac.Active__c = 'Yes';
    }
    }
}