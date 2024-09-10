public class CaseTriggerHandler {
    public static void com(List<Case> newCase)
    {
        for(Case c : newCase)
        {
            if(c.status == 'New' && String.isBlank(c.Comments)){
                c.addError('Please enter the comments');
            }
            else if(c.status == 'Working' && String.isBlank(c.Comments))
            {
                c.addError('Please enter the comments');
            }
            else if(c.status == 'Escalated' && String.isBlank(c.Comments))
            {
                c.addError('Please enter the comments');
            }
            else
            {
                
            }
        }
    }

}