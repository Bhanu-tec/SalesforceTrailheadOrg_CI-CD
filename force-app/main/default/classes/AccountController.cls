public  class AccountController {
    @AuraEnabled(cacheable = true)
    public static List<Account> getHighRevenueAccounts() {
        try {
            return [SELECT id,AccountNumber, Name, AnnualRevenue, NumberOfEmployees, Sic FROM Account WHERE AnnualRevenue != NULL ORDER BY AnnualRevenue DESC];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}