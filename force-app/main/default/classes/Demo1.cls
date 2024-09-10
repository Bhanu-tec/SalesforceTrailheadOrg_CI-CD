public class Demo1 
{
    Public static void FetchAccName(String p) { 
        Set<String> s1= new Set<String>();
       
        List<Account> acc=[Select id, Name From Account where Phone=:p];
       
        for(Account a:acc)
           
        {
           
            String s =a.name;
           
            s1.add(s);
           
        }
       
        System.debug('The Account Record Matching the Phone' +s1);
    }
}