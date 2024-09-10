@isTest
private class AssetServiceTest {

    @isTest
    static void testReportLostDeviceWithValidComprehensiveCoverage() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id);
        insert testContact;

        Asset testAsset = new Asset(Name = 'Test Asset', Asset_Identifier__c = 'TEST123', Status = 'Operational', AccountId = testAccount.Id, ContactId = testContact.Id);
        insert testAsset;

        Insurance__c testInsurance = new Insurance__c(Asset__c = testAsset.Id, Active__c = true, Coverage__c = 'Comprehensive', Start_Date__c = Date.today().addDays(-10), End_Date__c = Date.today().addDays(10));
        insert testInsurance;

        // Set up the request and response
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/lost';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"assetIdentifier":"TEST123"}');
        RestContext.request = req;
        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = AssetService.reportLostDevice('TEST123');
    }

    @isTest
    static void testReportLostDeviceWithNoInsurance() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id);
        insert testContact;

        Asset testAsset = new Asset(Name = 'Test Asset', Asset_Identifier__c = 'TEST456', Status = 'Operational', AccountId = testAccount.Id, ContactId = testContact.Id);
        insert testAsset;

        // Set up the request and response
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/lost';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"assetIdentifier":"TEST456"}');
        RestContext.request = req;
        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = AssetService.reportLostDevice('TEST456');
    }

    @isTest
    static void testReportLostDeviceWithExistingClaim() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id);
        insert testContact;

        Asset testAsset = new Asset(Name = 'Test Asset', Asset_Identifier__c = 'TEST789', Status = 'Operational', AccountId = testAccount.Id, ContactId = testContact.Id);
        insert testAsset;

        Insurance__c testInsurance = new Insurance__c(Asset__c = testAsset.Id, Active__c = true, Coverage__c = 'Comprehensive', Start_Date__c = Date.today().addDays(-10), End_Date__c = Date.today().addDays(10));
        insert testInsurance;

        Claim__c existingClaim = new Claim__c(Asset__c = testAsset.Id, Insurance__c = testInsurance.Id, Type__c = 'Loss', Status__c = 'New');
        insert existingClaim;

        // Set up the request and response
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/lost';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"assetIdentifier":"TEST789"}');
        RestContext.request = req;
        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = AssetService.reportLostDevice('TEST789');
    }

    @isTest
    static void testReportLostDeviceWithInvalidAssetIdentifier() {
        // Set up the request and response
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/lost';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"assetIdentifier":"INVALID"}');
        RestContext.request = req;
        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = AssetService.reportLostDevice('INVALID');
    }

    @isTest
    static void testReportLostDeviceWithMissingAssetIdentifier() {
        // Set up the request and response
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/lost';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{}');
        RestContext.request = req;
        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = AssetService.reportLostDevice(null);
    }
}