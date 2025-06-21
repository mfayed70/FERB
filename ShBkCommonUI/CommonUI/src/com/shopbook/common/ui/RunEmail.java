package com.shopbook.common.ui;

public class RunEmail {
    
    public static void main (String[]args) {
    SendEmail xx = new SendEmail();
    
    String[] toEmails = {"AAAA@yopmail.com"};
    xx.setSmtpHostPort("465");    
    xx.setSmtpHostServer("mail.mymr.health");
    xx.setSslOrTls("Ssl");
    xx.setFromEmail("registeration@mymr.health");
    xx.setPaswrd("bIY,i_]jRAAK");
    xx.setToEmails(toEmails);
    xx.setSubject("Teeeeeeest");
    xx.sendTestEmail(null);
    xx.sendSsl();
    
    }
}
