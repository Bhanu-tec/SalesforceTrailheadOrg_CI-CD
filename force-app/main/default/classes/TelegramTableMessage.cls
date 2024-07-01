// Table Format Messgage to Telegram Group using api.
public class TelegramTableMessage {
    public String chatId;// telegram chat Id
    public String message;
    public Boolean parseMode;
    
    //Parameter Constructor
    public TelegramTableMessage(String chatId, String message, Boolean parseMode) {
        this.chatId = chatId;
        this.message = message;
        this.parseMode = parseMode;
    }
    
    public void send() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.telegram.org/bot<your_bot_token>/sendMessage');
        req.setMethod('POST');
        
        // Create HTML table
        String table = '<table>';
        List<List<String>> rows = new List<List<String>>();
        rows.add(new List<String>{'Header 1', 'Header 2'});
        rows.add(new List<String>{'Data 1.1', 'Data 1.2'});
        rows.add(new List<String>{'Data 2.1', 'Data 2.2'});
        for (List<String> row : rows) {
            table += '<tr>';
            for (String column : row) {
                table += '<td>' + column + '</td>';
            }
            table += '</tr>';
        }
        table += '</table>';
        
        req.setBody('{' +
                    '"chat_id": "' + chatId + '",' +
                    '"text": "' + message + '",' +
                    '"parse_mode": "HTML"' +
                    '}');
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
}