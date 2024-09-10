public class testdelete {
    public List<Candidate__c> cam = new List<Candidate__c>();
    public  testdelete(){
        cam=[SELEcT Name FROM Candidate__c];
        System.debug(cam);
    }

}