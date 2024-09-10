public class casehandler {
    public static void sys(List<case> newcase)
    {
        for(Case cs : newcase)
        {
            if(cs.Origin == 'Email' && cs.Status == 'New')
            {   
              cs.Priority = 'Medium';
            }
        }
    }

}