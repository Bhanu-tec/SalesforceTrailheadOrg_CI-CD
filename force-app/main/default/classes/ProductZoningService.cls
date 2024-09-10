@RestResource(urlMapping='/ProductZoning/*')
global with sharing class ProductZoningService {
    
    @HttpGet
    global static String doGet() {
        RestRequest req = RestContext.request;
        
        String countryCode = req.headers.get('CountryCode');
        String prodCode = req.params.get('ProductCode');
        
        if (String.isBlank(countryCode)) {
            countryCode = 'US';
        }
        
        if (String.isBlank(prodCode)) {
            return 'ProductCode is missing or doesn\'t exist';
        }
        
        List<Product2> prodLst = [SELECT Family FROM Product2 WHERE ProductCode = :prodCode];
        
        if (prodLst.isEmpty()) {
            return 'ProductCode is missing or doesn\'t exist';
        }
        
        List<Product_Geo_Mapping__mdt> pfz = [SELECT Permissible_Fly_Zone__c 
                                              FROM Product_Geo_Mapping__mdt 
                                              WHERE Product_Family__c = :prodLst[0].Family 
                                              AND Country_Code__c = :countryCode];
        
        if (pfz.isEmpty()) {
            return 'Confirm with the local authorities';
        } else {
            return pfz[0].Permissible_Fly_Zone__c;
        }
    }
}