global class SLA_scheduleapex implements Schedulable{
    global void execute(SchedulableContext SC){
        SLA_1_fields_update sf = new SLA_1_fields_update();
        String cron_exp = '0 * * ? * *';
        System.schedule('jobName1', cron_exp, sf);
    }
}