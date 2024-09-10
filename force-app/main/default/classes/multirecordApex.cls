public with sharing class multirecordApex 
{
 public PageReference remove() 
    {
     Integer idx=0;
     Boolean found=false;
     for(candidateKeywrapper w:lstwrap)
     {
     if(w.Key == keyToDelete)
     {
         found=true;
         toDelete.add(w.can);
         break;
         }
         else
         {
         idx++;
         }
     }
     if(found)
     {
     lstwrap.remove(idx);
     }
                  return null;
    }

 public  List<candidateKeywrapper> lstwrap{get;set;}
  public Integer addItemcount{get;set;}
  public Integer mainkey{get;set;}
  public List<Candidate__c> toDelete=new List<Candidate__c>();
  public Integer keyToDelete{get;set;} 
 
 public multirecordApex()
 {
 
 addItemcount=3;
 mainkey=1;
 lstwrap=new List<candidateKeywrapper>();
 List<Candidate__c> Listcan=[select Full_Name__c,Email_id__c from Candidate__c limit :5];
 for(Candidate__c  c : Listcan)
 {
 lstwrap.add(new candidateKeywrapper(mainkey++,c));
 }
 }
 
    public void addItem() 
    {
    if((addItemcount >0) && (addItemcount<10))
    {
    for(Integer i=0;i<addItemcount;i++)
    {
     lstwrap.add(new candidateKeywrapper(mainkey++,new Candidate__c()));

    }
    }
    
    }public PageReference save() 
         {
         Boolean error=false;
         
         List<Candidate__c>  toupsert=new List<Candidate__c>();
         for(candidateKeywrapper w : lstwrap)
         {
         if((w.can.Full_Name__c  == ' ' )|| (w.can.Email_id__c ==' '))
         {
          w.can.Full_Name__c.addError('the nam cannot be blank');
          error=true;
         }
         else
         {
         toupsert.add(w.can);
         }
        
         }  
          if(!error)
         {
         upsert toupsert;
         delete toDelete;
         }
      return null;
    }
    
}