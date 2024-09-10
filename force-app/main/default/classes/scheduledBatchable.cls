global class scheduledBatchable implements Schedulable {
   global void execute(SchedulableContext sc) {
      BatchDelete b = new BatchDelete(); 
      Database.executeBatch(b);
   }
}