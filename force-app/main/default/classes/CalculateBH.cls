public class CalculateBH 
{
    public Static void WorkingHours(List<DLP__c> dlp)
    {
       // BusinessHours bh = [Select Id From BusinessHours Where id = '01m5g000001TAPDAA4'];
        //List<DLP__c> dlp = [SELECT test_field__c,workingHours__c FROM DLP__c WHERE Id = 'a065g00000EjX7iAAF'];
        for(DLP__c dp :dlp)
        {
           DateTime startDate = dp.test_field__c;
           DateTime endDate = DateTime.now();
           Decimal result = BusinessHours.diff('01m5g000001TAPDAA4', startDate, endDate); 
           Decimal resultingHours = (result/(60*60*1000));
           System.debug('resultingHours :'+resultingHours);
           
           dp.workingHours__c = resultingHours;   
        }
        
    }
     
}