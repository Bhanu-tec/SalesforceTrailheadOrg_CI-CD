public with sharing class wrapperTable {
    public wrapperTable() {

    }
    @AuraEnabled(cacheable=true)
	public static String getAccounts(){
        Integer rowIndex = 0;
        List<accountWrap> accWrapList = new List<accountWrap>();
		try {
            List<Account> accList = [SELECT Id, Name, Phone FROM Account limit 10];
            for(Account a : accList){
            accWrapList.add(new accountWrap(a.Id,a.Name,a.Phone,rowIndex));
            rowIndex++;
            }
            return JSON.serialize(accWrapList);
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
	}
    public class accountWrap{
        public String Id;
        public String AccountName;
        public String Phone;
        public Boolean isSelected;
        public Integer index;
	    public accountWrap(String Id, String AccountName, String Phone, Integer index){
            this.Id = Id;
            this.AccountName = AccountName;
            this.Phone = Phone;
            this.isSelected = false;
            this.index = index;
		}
            
    }
}