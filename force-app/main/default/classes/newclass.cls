public class newclass {
    public static void new1(){
	 List<Product2> prodLst = [SELECT Id, Family FROM Product2 WHERE ProductCode = : 'GC5040'];
System.debug(prodlst);
    }
}