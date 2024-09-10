public class CalculateFieldWorkingHours 
{
    public static void working_hours()
    { 
        List<DLP__c> lst = [SELECT CreatedDate FROM DLP__c WHERE Id = 'a065g00000EjWMDAA3'];
        for(DLP__c d : lst)
        {
            DateTime SD = d.CreatedDate;
            DateTime ED = system.now();
           
            DateTime et = Datetime.now();
            Integer offset = UserInfo.getTimezone().getOffset(et);
            Datetime local = et.addSeconds(offset/1000);
            System.debug(local);
            
            integer Days = SD.date().daysBetween(ED.date());
            datetime sameDayEndDate = SD.addDays(Days);
            decimal decHours =/* ((ED.getTime())/1000/60/60);*/ ((sameDayEndDate.getTime())/1000/60/60);
            System.debug(ED);
            System.debug(decHours);
            System.debug(Days);
           /* Date CD = date.newInstance(SD.year(), SD.month(), SD.day());
            Integer day = CD.Day(); //get day
            Integer month = CD.Month(); //get month
            Integer year = CD.Year(); //get year
            
            DateTime ED = System.today();
            Date TD = date.newInstance(ED.year(), ED.month(), ED.day());
            Integer Eday = ED.Day(); //get day
            Integer Emonth = ED.Month(); //get month
            Integer Eyear = ED.Year(); //get year            
            
            Integer wd = (Eday-day + Emonth-month + Eyear-year);
            System.debug(wd);*/
            
           /* DateTime st = d.CreatedDate;
            Integer sth = st.hour();
            Integer stm = st.minute();
            
            DateTime et = Datetime.now();
            Integer offset = UserInfo.getTimezone().getOffset(et);
            Datetime local = et.addSeconds(offset/1000);
            System.debug(local);
           
            Integer eth = et.hour();
            Integer etm = et.minute();
            
            Integer wh = eth-sth;
            Integer wm = etm-stm;
            System.debug(wh+':'+wm);*/
            
        }
            
    }
 
}