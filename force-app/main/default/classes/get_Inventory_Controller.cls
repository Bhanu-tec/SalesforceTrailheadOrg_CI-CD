public with sharing class get_Inventory_Controller {
    @AuraEnabled(cacheable=true)
    public static List<Product2> get_Inventory() {
        List<Product2> prodList = [SELECT Id, Name, QuantityUnitOfMeasure,ProductCode  FROM Product2 LIMIT 10];
        return prodList;
    }
}