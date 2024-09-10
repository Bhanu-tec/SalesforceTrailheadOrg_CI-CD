public class BookDiscountClass 
{
 public static void applyDiscount(Book__c book)
    {
        
    if(book.Publisher__c=='A')
    {
        book.After_Discount_Price__c=book.Book_Price__c*0.8;
    }
        
    else if(book.Publisher__c=='B')
    {
        book.After_Discount_Price__c=book.Book_Price__c*0.85;
    }
    else if(book.Publisher__c=='C')
    {
        book.After_Discount_Price__c=book.Book_Price__c*0.90;
    }
    else if(book.Publisher__c=='D')
    {
        book.After_Discount_Price__c=book.Book_Price__c*0.95;
    }
    }
    
}