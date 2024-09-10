global class FutureMethodRecordProcessing {
    @InvocableMethod
    public static void processRecords(List<ID> recordIds) {
        // Get those records based on the IDs
        List<WorkOrderLineItem> results = [SELECT Id, Discount, UnitPrice, Product2__c FROM WorkOrderLineItem WHERE WorkOrder.Id IN :recordIds];

        // Prepare the JSON request body for the callout
        String clientCode = '123';
        String pricebookCode = '123';
        List<Map<String, Object>> products = new List<Map<String, Object>>();
        for (WorkOrderLineItem result : results) {
            Map<String, Object> product = new Map<String, Object>();
            product.put('productcode', result.Id);
            product.put('productprice', result.UnitPrice);
            product.put('discount', result.Discount);
            products.add(product);
        }
        Map<String, Object> requestBody = new Map<String, Object>();
        requestBody.put('client_code', clientCode);
        requestBody.put('pricebook_code', pricebookCode);
        requestBody.put('products', products);
        String requestJson = JSON.serialize(requestBody);

        System.debug('1.requestJson: ' + requestJson);

        // Make the callout
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://semat-productprice.de-c1.eu1.cloudhub.io/api/getProductPrice');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(requestJson);
        HttpResponse response = http.send(request);

        System.debug('2.response: ' + response);

        // Parse the response and update the records
        if (response.getStatusCode() == 202) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Map<String, Object>> productPrices = new List<Map<String, Object>>();
            for (Object productPrice : (List<Object>) responseMap.get('productprice')) {
                productPrices.add((Map<String, Object>) productPrice);
            }
            for (WorkOrderLineItem result : results) {
                for (Map<String, Object> productPrice : productPrices) {
                    if (result.Id == (String) productPrice.get('productcode')) {
                        result.UnitPrice = (Decimal) productPrice.get('unitprice');
                        result.Discount = (Decimal) productPrice.get('discount');
                        break;
                    }
                }
            }
            update results;
        } else {
            // Handle error
        }
    }
}



        /*JSONGenerator jRecordList = JSON.createGenerator(true);
        jRecordList.writeStartObject(); 
        jRecordList.writeFieldName('records');
        jRecordList.writeStartArray();
        
        for(WorkOrderLineItem wo: workItemlist){
            jRecordList.writeStartObject();
            jRecordList.writeStringField('Id', wo.Id);
            if(wo.Quantity == Null){
                jRecordList.writeNullField('neededQuantity');
            }
            else{
                jRecordList.writeNumberField('neededQuantity',wo.Quantity);
            }
            jRecordList.writeEndObject(); 
        }
        jRecordList.writeEndArray();
        jRecordList.writeEndObject();
        String jsonData = jRecordList.getAsString();
        System.debug('Json Data - ' + jsonData);
        
        String urlToQuery = 'http://checksnowflake.de-c1.eu1.cloudhub.io/semat';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(urlToQuery);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
        req.setBody(jRecordList.getAsString());
        //req.setTimeout(120000);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        String returnValue = res.getBody();
        System.debug('<<<<<<<<<<' + 'API_Response' + '>>>>>>>>>>');
        System.debug(returnValue);
        if(res.getBody() != null && res.getBody().length() > 0) {
			List<AccInfo> data = (List<AccInfo>) JSON.deserialize(res.getBody(), List<AccInfo>.class);
        	System.debug(data);
        	return data;
    	} 
    	else {
    		return null;
		}*/