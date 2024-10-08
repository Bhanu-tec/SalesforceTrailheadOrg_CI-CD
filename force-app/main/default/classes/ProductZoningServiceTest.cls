@isTest(SeeAllData=true)
public class ProductZoningServiceTest {
    @isTest
    static void testGetProductZoning_InvalidInput1() {
        Test.startTest();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning';
        req.httpMethod = 'GET';
        req.addHeader('CountryCode', '');
        req.addParameter('ProductCode', 'GC1060');
        RestContext.request = req;
        RestContext.response= res;
        
        // Call the service
        ProductZoningService.doGet();
        
        // Check result
        //System.assertEquals('Regulated', result);
        
        Test.stopTest();
    }
    
    @isTest
    static void testGetProductZoning_InvalidInput2() {
        Test.startTest();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.httpMethod = 'GET';
        req.addHeader('CountryCode', 'AU');
        req.addParameter('ProductCode', 'IN7020');
        RestContext.request = req;
        RestContext.response= res;
        
        // Call the service
        ProductZoningService.doGet();
        
        // Check result
        //System.assertEquals('Confirm with the local authorities', result);
        
        Test.stopTest();
    }
    
    @isTest
    static void testGetProductZoning_InvalidInput3() {
        Test.startTest();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.httpMethod = 'GET';
        req.addHeader('CountryCode', 'DE');
        req.addParameter('ProductCode', 'IN99920');
        RestContext.request = req;
        RestContext.response= res;
        
        // Call the service
        ProductZoningService.doGet();
        
        // Check result
        //System.assertEquals('ProductCode is missing or does not exist', result);
        
        Test.stopTest();
    }
    @isTest
    static void testGetProductZoning_InvalidInput4() {
        Test.startTest();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.httpMethod = 'GET';
        req.addHeader('CountryCode', '');
        req.addParameter('ProductCode', '');
        RestContext.request = req;
        RestContext.response= res;
        
        // Call the service
        ProductZoningService.doGet();
        
        // Check result
        //System.assertEquals('ProductCode is missing or does not exist', result);
        
        Test.stopTest();
    }
    @isTest
    static void testGetProductZoning_InvalidInput5() {
        Test.startTest();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.httpMethod = 'GET';
        req.addHeader('CountryCode', '');
        req.addParameter('ProductCode', 'IN28391234');
        RestContext.request = req;
        RestContext.response= res;
        
        // Call the service
        ProductZoningService.doGet();
        
        // Check result
        //System.assertEquals('ProductCode is missing or does not exist', result);
        
        Test.stopTest();
    }
}