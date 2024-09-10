public class ApexSchedularClass Implements Schedulable
{
 public void execute(SchedulableContext sc)
 {
      ApexBatchClassSample b= new ApexBatchClassSample();
         Database.executeBatch(b,100);
 }
}