public with sharing class test11Apex {

    public List<Account> accList{get; set;}
    
    public test11Apex()
    {
       accList=[select Name,type,(select Name,Phone from Contacts) from Account];
    }
}