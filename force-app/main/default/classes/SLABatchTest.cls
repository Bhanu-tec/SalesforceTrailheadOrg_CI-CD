@isTest
public class SLABatchTest {
    static testmethod void test(){
        Test.startTest();
        Project_Defect__c pd = new Project_Defect__c();
        pd.SLA1_isActive__c = True;
        if(pd.SLA1_isActive__c){
            pd.SLA1_currentElapTime__c = System.Datetime.now();
        }
        
        
    }
}