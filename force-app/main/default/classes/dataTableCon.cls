public class dataTableCon {
    List<Account> accounts;
    public List<Account> getAccounts() {
            return [SELECT Name, Rating, Industry FROM Account LIMIT 20];
    }
}