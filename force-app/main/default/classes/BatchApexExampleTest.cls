@isTest
private class BatchApexExampleTest {
     static testmethod void test() {
        Test.startTest();
        Pen__c p = new Pen__c();
        p.Pen_type__c= 'Boll Pen'; 
        p.Pen_Color__c= 'Red'; 
        p.Pen_Cost__c = '20'; 
        insert p;
        BatchDelete b = new BatchDelete();
        Database.executeBatch(b);
        Test.stopTest();

    }
}