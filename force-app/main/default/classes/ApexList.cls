public class ApexList 
{
 public  void Listtest() {  
     Integer Totalsum=0;
        List < Integer > num = new List < Integer > {1,2,3,4,5};
            for(Integer i=0; i<num.size();i++)
        {
            Totalsum = Totalsum+num[i];
        }
   System.debug('Totalsum ='+Totalsum);
    } 
}