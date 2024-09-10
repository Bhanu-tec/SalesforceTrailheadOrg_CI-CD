public class AcountAction 
{
    public static void createaction(List<Account> actlst)
{
    List<Contact> conlst = new List<Contact>();
    for(Account act: actlst)
    {
        Contact cnt = new Contact();
        cnt.AccountId = act.id;
        cnt.LastName = act.Name;
        conlst.add(cnt);
    }
    
    if(!conlst.isEmpty())
    {
        insert conlst;
    }
}
    
    public static void createOpp(Map<id,Account> newactmap, Map<id,Account> oldactmap)
    {
        list<Opportunity> opplst = new list<Opportunity>();
        for(Account act : newactmap.values())
        {
        if(newactmap.get(act.Id).Rating != oldactmap.get(act.Id).Rating && newactmap.get(act.Id).Rating=='Warm')
        {
            Opportunity opp = new Opportunity();
            opp.AccountId = act.Id;
            opp.Name = act.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = system.today();
            opplst.add(opp);
        }
        }
        
        if(!opplst.isEmpty())
        {
        insert opplst;
        }
    }
}