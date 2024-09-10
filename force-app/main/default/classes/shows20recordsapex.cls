public class shows20recordsapex {

    public String accList { get; set; }
    public List<Contact> ContList
    {
        get;
        set;
    }
    public shows20recordsapex() {
        ContList = [Select Name,Email from Contact];
    }
}