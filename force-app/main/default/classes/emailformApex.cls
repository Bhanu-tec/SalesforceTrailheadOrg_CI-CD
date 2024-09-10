public with sharing class emailformApex 
{
    public string emailId{get;set;}
    public string emailSubject{get;set;}
    public string emailMessage{get;set;}

    public PageReference sendEmail() {
        List<Messaging.SingleEmailMessage> lstEmailId=new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {emailId});
        mail.setReplyTo('bhanu2919109@gmail.com');
        mail.setPlainTextBody(emailMessage);
        mail.setSenderDisplayName('S Bhanu Prasad');
        mail.setSubject(emailSubject);
        
        lstEmailId.add(mail);
        
        try
        {
            Messaging.sendEmail(lstEmailId);
              ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Email Sent Successfully'));
               emailId='';
               emailSubject='';
               emailMessage='';

        }
        catch(Exception ex)
        {
              ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Error,ex.getMessage()));
        }
        return null;
    }

}