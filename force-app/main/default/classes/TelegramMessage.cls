public class TelegramMessage {
    public String chatId;
    public String message;
    public Boolean parseMode;
    
    public TelegramMessage(String chatId, String message, Boolean parseMode) {
        this.chatId = chatId;
        this.message = message;
        this.parseMode = parseMode;
    }
    
    public void send() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.telegram.org/bot<your_bot_token>/sendMessage');
        req.setMethod('POST');
        req.setBody('{' +
                    '"chat_id": "' + chatId + '",' +
                    '"text": "' + message + '",' +
                    '"parse_mode": ' + parseMode +
                    '}');
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
}