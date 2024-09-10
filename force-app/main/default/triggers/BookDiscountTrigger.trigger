trigger BookDiscountTrigger on Book__c (before insert,before update) 
{
    Book__c b=Trigger.New[0];
    BookDiscountClass.applyDiscount(b);
}