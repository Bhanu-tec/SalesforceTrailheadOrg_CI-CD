public class standardizeNameField 
{
    public void standardize(string nameField)
    {
        string result = nameField?.toLowerCase();
        
        if(nameField != null)
        {
            //Remove Dashes, slashes and apostrophe to be able to Capitalize
            result = result.replace('-', '130011DASH130011');
            result = result.replace('/', '130011APOS1130011');
            result = result.replace(',', '130012APOS1130012');
            
            string newresult='';
            
            for(string t : result.split(' ')){
                newresult += t.capitalize()+' ';
            }
            //Extra spaces are removed
            result = newresult.replace('\\s{2,}', ' ');
            
            //Set back dash and apostrophe
            result = result.replace('130011DASH130011', '-');
            result = result.replace('130011APOS1130011', '/');
            result = result.replace('130012APOS1130012', ',');
            
            result = result.replaceAll('-+', '-');
            result = result.replaceAll('/+', '/');
            result = result.replaceAll(',+', ',');
            result = result.replaceAll('#+', '#');
            
        }
        
        system.debug(result);   
    }
    
}