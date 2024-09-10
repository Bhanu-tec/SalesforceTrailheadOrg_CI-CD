@isTest
private class CredentialVerificationServiceTest {
    @isTest
    static void testValidCertification() {
        Contact contact = new Contact(LastName = 'Doe');
        insert contact;
        
        Certification__c certification = new Certification__c(Name = 'Drone Operator');
        insert certification;
        
        Contact_Certification__c contactCertification = new Contact_Certification__c(
            Contact__c = contact.Id,
            Certification__c = certification.Id,
            isActive__c = true,
            Issue_Date__c = Date.today()
        );
        insert contactCertification;
        List<Contact_Certification__c> contactCertifications = [
            SELECT Name, Contact__r.LastName, Certification__r.Name, isActive__c
            FROM Contact_Certification__c WHERE Id =: contactCertification.Id];

        String result = CredentialVerificationService.verifyCredential('Doe', contactCertifications[0].Name);
        System.assertEquals('Valid', result);
    }
    
    @isTest
    static void testNeedsRenewalCertification() {
        Contact contact = new Contact(LastName = 'Doe');
        insert contact;
        
        Certification__c certification = new Certification__c(Name = 'Drone Operator');
        insert certification;
        
        Contact_Certification__c contactCertification = new Contact_Certification__c(
            Contact__c = contact.Id,
            Certification__c = certification.Id,
            isActive__c = false,
            Issue_Date__c = Date.today()
        );
        insert contactCertification;
        
        List<Contact_Certification__c> contactCertifications = [
            SELECT Name, Contact__r.LastName, Certification__r.Name, isActive__c
            FROM Contact_Certification__c WHERE Id =: contactCertification.Id];

        String result = CredentialVerificationService.verifyCredential('Doe', contactCertifications[0].Name);
        System.assertEquals('Needs Renewal', result);
    }
    
    @isTest
    static void testNoRecordFound() {
        String result = CredentialVerificationService.verifyCredential('Nonexistent', 'Nonexistent Certification');
        System.assertEquals('No record found', result);
    }
    
    @isTest
    static void testBlankInputs() {
        
        Contact contact = new Contact(LastName = 'Doe');
        insert contact;
        
        Certification__c certification = new Certification__c(Name = 'Drone Operator');
        insert certification;
        
        Contact_Certification__c contactCertification = new Contact_Certification__c(
            Contact__c = contact.Id,
            Certification__c = certification.Id,
            isActive__c = true,
            Issue_Date__c = Date.today()
        );
        insert contactCertification;
        
        List<Contact_Certification__c> contactCertifications = [
            SELECT Name, Contact__r.LastName, Certification__r.Name, isActive__c
            FROM Contact_Certification__c WHERE Id =: contactCertification.Id];
        
        String result = CredentialVerificationService.verifyCredential('', contactCertifications[0].Name);
        System.assertEquals('No record found', result);
        
        result = CredentialVerificationService.verifyCredential('Doe', '');
        System.assertEquals('No record found', result);
        
        result = CredentialVerificationService.verifyCredential('', '');
        System.assertEquals('No record found', result);
    }
}