global class SLA11SchedulableClass  implements Schedulable 
{
    global void execute(SchedulableContext ctx) 
    {
         SLA11Batchclass s = new SLA11Batchclass();
          Database.executeBatch(s, 1);
    }
}