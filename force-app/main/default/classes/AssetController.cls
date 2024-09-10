public class AssetController {
    
    @AuraEnabled(cacheable=true)
    public static List<Asset> getAssets() {
        return [SELECT Id, Name FROM Asset];
    }
    
    @AuraEnabled
    public static void insertAsset(Id workOrderId, List<Asset> selectedAssets) {
        List<WorkOrderLineItem> workOrderLineItems = new List<WorkOrderLineItem>();
        
        for(Asset asset : selectedAssets) {
            WorkOrderLineItem workOrderLineItem = new WorkOrderLineItem();
            workOrderLineItem.WorkOrderId = workOrderId;
            workOrderLineItem.AssetId = asset.Id;
            workOrderLineItems.add(workOrderLineItem);
        }
        
        insert workOrderLineItems;
    }
    
}