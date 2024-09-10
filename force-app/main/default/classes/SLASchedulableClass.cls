global class SLASchedulableClass implements Schedulable{
    global void execute(SchedulableContext SC){
        Database.executeBatch(new SLABatchclass());	
    }
}