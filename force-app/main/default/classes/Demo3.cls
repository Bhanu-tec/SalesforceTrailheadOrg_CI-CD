public class Demo3 
{
public static void method()
{
 integer[] a = new integer[10];
for(integer i=0; i<10; i++)
 a[i] = i * 10; 
 
for(integer i=0; i<10; i++)
 System.debug(a[i]); 

System.debug('Array Elements Reverse Order');

for(integer i = a.size()-1; i>=0; i--)
 System.debug(a[i]);
}
}