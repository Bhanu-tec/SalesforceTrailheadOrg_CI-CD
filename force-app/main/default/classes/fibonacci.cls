public class fibonacci {
    public void fi(Integer x, Integer y){
        Integer z;
        Integer count=10;
        for(Integer i=0;i<count;i++){
            z=x+y;
            x=y;
            y=z;
            system.debug(z);
        }
        System.debug(z);   
    }
}