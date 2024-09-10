@isTest
public class WorkOrderLineItemTriggerHandlerTest {

    static testMethod void testOnBeforeDelete() {
        // Create test data
        WorkOrder wo = new WorkOrder();
        wo.Status = 'Closed';
        insert wo;
        WorkOrderLineItem woli = new WorkOrderLineItem();
        woli.Tech_undeletable__c = True;
        woli.WorkOrderId = wo.Id;
        insert woli;
        
        // Test as a non-admin user
        Test.startTest();
        User nonAdmin = createTestUser('Non Admin');
        System.runAs(nonAdmin) {
            List<WorkOrderLineItem> workItemlist = new List<WorkOrderLineItem>{woli};
            WorkOrderListItemTriggerHandler.onBeforeDelete(workItemlist);
            //System.assertEquals(workItemlist[0].getErrorCount(), 1, 'Error message should be displayed');
            System.assertEquals(workItemlist[0].getErrors()[0].getMessage(), 'You are not allowed to delete this record', 'Error message should be displayed');
        }
        Test.stopTest();
        
        // Test as an admin user
        Test.startTest();
        User admin = createTestUser('Admin');
        System.runAs(admin) {
            List<WorkOrderLineItem> workItemlist = new List<WorkOrderLineItem>{woli};
            WorkOrderListItemTriggerHandler.onBeforeDelete(workItemlist);
            //System.assertEquals(workItemlist[0].getErrorCount(), 0, 'Error message should not be displayed');
        }
        Test.stopTest();
    }
    
    static User createTestUser(String profileName) {
        Profile p = [SELECT Id FROM Profile WHERE Name = :profileName];
        User u = new User(
            ProfileId = p.Id,
            Email = 'testuser@test.com',
            Username = 'testuser@test.com',
            FirstName = 'Test',
            LastName = 'User',
            Alias = 'testuser'
        );
        insert u;
        return u;
    }
}