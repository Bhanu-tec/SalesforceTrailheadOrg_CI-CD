public with sharing class multiemailsApex
{

    public List<wrapper> lstwrap{get;set;}
    
  
  
  public multiemailsApex()
  {
  lstwrap=new List<wrapper>();
  List<Candidate__c> canList=[select Name,Full_Name__c,Email_id__c,Phone_Number__c from Candidate__c];
  for(Integer i=0;i<canList.size();i++)
  {
  lstwrap.add(new wrapper(canList[i],false));
  
  }
  }



public class wrapper
{

public Candidate__c can{get;set;}
public boolean  checkbox{get;set;}
public wrapper(Candidate__c canobj, Boolean check)
{
   can=canobj;
   checkbox=check;
}
}

    public void SendEmail() 
    {
    List<Messaging.SingleEmailMessage> lstemailid = new List<Messaging.SingleEmailMessage>();
    for(wrapper w:lstwrap)
    {
    
    if(w.checkbox== true)
    {
    Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
    mail.setToAddresses(new String[] {w.can.Email_id__c});
    mail.setReplyTo('bhanu2919109@gmail.com');
    mail.setPlainTextBody('hello from salesforce Developer');
    mail.setSenderDisplayName('S Bhanu Prasad');
    mail.setSubject('test message from from apex ');
     
       lstemailid.add(mail);
        }
        }
        if(lstemailid.size()>0)
        {   
         try
    {
        Messaging.sendEmail(lstemailid);
        }
           catch(Exception ex)
     {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
}

            
            }
            
    }


}