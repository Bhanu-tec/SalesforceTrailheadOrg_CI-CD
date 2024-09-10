public class PassByReference 
{
    public void mainvalueMethod()
    {
       String websiteURL='www.salesforce.com';
       System.debug('Before value call:' +websiteURL);
       passByValuecall(websiteURL);
       system.debug('After value call:' +websiteURL);
    } 
    private void passByValueCall(String websiteURLvalue)
    {
        websiteURLvalue = 'www.trailhead.com';
    }
    
    
    public void mainreferenceMethod()
    {
        Account a=new Account();
        a.Name='Test Account';
        a.website='www.salesforce.com';
        system.debug('Before reference call: '+a);
        passByRefCall(a);
        system.debug('After refernece call: '+a);
    }
    private void passByRefCall(account a)
    {
        a.website='www.trailhead.com';
    }    

}