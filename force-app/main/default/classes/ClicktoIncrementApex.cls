public with sharing class ClicktoIncrementApex {

    public Integer num { get; set; }
    
    public ClicktoIncrementApex()
    {
    num=0;
    }

    public PageReference click()
     {
     num++;
        return null;
     }
     

}