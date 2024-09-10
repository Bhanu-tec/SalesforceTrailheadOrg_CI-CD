@RestResource(urlMapping='/lost')
global with sharing class AssetService {

    @HttpPost
    global static String reportLostDevice(String assetIdentifier) {
        RestRequest req = RestContext.request;
        //RestResponse res = RestContext.response;
        //res.addHeader('Content-Type', 'application/json');
        
        if (String.isBlank(assetIdentifier)) {
            //res.statusCode = 400;
            return 'No device found.';
        }
        
        // Fetch the asset using assetIdentifier
        List<Asset> assets = [SELECT Id, Status FROM Asset WHERE Asset_Identifier__c = :assetIdentifier LIMIT 1];
        
        if(assets.size()>0){
            Asset asset = assets[0];
            asset.Status = 'Lost';
            update asset;
            
            // Fetch insurance policy for the asset
        	List<Insurance__c> insurances = [SELECT Id, Active__c, Coverage__c FROM Insurance__c WHERE Asset__c = :asset.Id AND Active__c = TRUE LIMIT 1];
            if(insurances.size()>0 && insurances[0].Coverage__c == 'Comprehensive'){
                List<Claim__c> claims = [SELECT Id,Name FROM Claim__c WHERE Insurance__c = :insurances[0].Id AND Type__c = 'Loss' LIMIT 1];
                if(claims.size()==0){
                    Claim__c newClaim = new Claim__c();
                    newClaim.Asset__c = asset.Id;
                    newClaim.Insurance__c = insurances[0].Id;
                    newClaim.Status__c = 'New';
                    newClaim.Type__c = 'Loss';
                    insert newClaim;
                    
                    Claim__c claimUpdated = [SELECT Id,Name FROM Claim__c WHERE Insurance__c = :insurances[0].Id AND Type__c = 'Loss' Order by CreatedDate DESC LIMIT 1 ];
                    return claimUpdated.Name;
                }else{
                    return claims[0].Name +' already filed.';
                }
            }else{
                return 'No coverage. Asset status adjusted to Lost.';
            }
            
            
           /* if (insurances.size()>0 && insurances[0].Coverage__c == 'Comprehensive') {
                // Check for existing loss claim
        		List<Claim__c> existingClaims = [SELECT Id, Name FROM Claim__c WHERE Asset__c = :asset.Id AND Type__c = 'Loss' LIMIT 1];
			
                if (!existingClaims.isEmpty()) {
                    return existingClaims[0].Name + ' already filed.';
                }else{
                    Claim__c newClaim = new Claim__c();
                    newClaim.Asset__c = asset.Id;
                    newClaim.Insurance__c = insurances[0].Id;
                    newClaim.Status__c = 'New';
                    newClaim.Type__c = 'Loss';
                    insert newClaim;
                    
                    Claim__c claimUpdated = [SELECT Id,Name FROM Claim__c WHERE Insurance__c = :insurances[0].Id AND Type__c = 'Loss' Order by CreatedDate DESC LIMIT 1 ];
                    return claimUpdated.Name;
                }
            }else {
                return 'No coverage. Asset status adjusted to Lost.';
            }*/
        }else {
            return 'No device found.';
        } 
    }
}