public class pattern 
{
   public static void  right_pattern(Integer n)
    {
        Integer a;
        Integer b;
        
        for(a=0;a<n;a++)
        {
            for(b=0;b<=a;b++)
            {
                System.debug('* ');
            }                                     
            System.debug('');
        }
    }
}