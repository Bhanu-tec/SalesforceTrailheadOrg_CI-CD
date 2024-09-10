public class wrapperc {
    public wrapperc(){
       wrap ww = new wrap();
        ww.s='shashi';
        System.debug(ww.s);
    }
    
    public class wrap{
        public String s;
    }

}