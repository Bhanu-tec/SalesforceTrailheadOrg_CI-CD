@RestResource(urlMapping='/ProductZoning/*')
global with sharing class ProductZoningService {
    
    @HttpGet
    global static void doGet (){
        
        String countryCode;
        String prodCode;
        String permFlyZone;
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'text/plain');
        countryCode = req.headers.get('CountryCode');
        prodCode = req.params.get('ProductCode');
        
        if (String.Isblank(prodCode)){
           permFlyZone = 'ProductCode is missing or does not exist';
           res.responseBody = blob.valueOf(permFlyZone);
           res.statusCode = 500;
        }
        
        if (String.Isblank(countryCode)){
            res.addHeader('CountryCode', 'US');
            res.addHeader('Content-Type', 'application/json');
            countryCode = res.headers.get('CountryCode');
        }

        if (!String.Isblank(prodCode) && countryCode=='US'){
            List<Product2> prodLst = [SELECT Id, Family FROM Product2 WHERE ProductCode = : prodCode with USER_MODE];
            
            If (prodLst.IsEmpty()){
                permFlyZone ='ProductCode is missing or does not exist';
                res.responseBody = blob.valueOf(permFlyZone);
                res.statusCode = 200;
            }
            
            if (!prodLst.IsEmpty()){
                List<Product_Geo_Mapping__mdt> pfz = [SELECT Permissible_Fly_Zone__c 
                                                      FROM Product_Geo_Mapping__mdt 
                                                      WHERE Product_Family__c = : prodLst[0].Family AND Country_Code__c = : countryCode];
                
                if(!pfz.isEmpty()){
                   permFlyZone =  String.valueof(pfz[0].Permissible_Fly_Zone__c);
                   res.responseBody = blob.valueOf(permFlyZone);
                    res.statusCode = 200;
                }
            } 
            
        }
        if (!String.Isblank(prodCode)  && countryCode!='US'){
            List<Product2> prodLst = [SELECT Family FROM Product2 WHERE ProductCode = : prodCode];
            If (prodLst.IsEmpty()){
                permFlyZone = 'ProductCode is missing or does not exist';
                res.responseBody = blob.valueOf(permFlyZone);
                res.statusCode = 500;
            }
            if (!prodLst.IsEmpty()){
                List<Product_Geo_Mapping__mdt> pfz = [SELECT Permissible_Fly_Zone__c 
                                                      FROM Product_Geo_Mapping__mdt 
                                                      WHERE Product_Family__c = : prodLst[0].Family AND Country_Code__c = : countryCode];
                if(!pfz.isEmpty()){
                	 permFlyZone = 'Confirm with the local authorities';
                    res.responseBody = blob.valueOf(permFlyZone); 
                    res.statusCode = 500;
                }
            }
            
        }
    }
}