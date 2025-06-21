package com.shopbook.common.adsEmail;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class PrepareToSend {
    public static void senEmail(String host, String port,
            final String userName, final String password,HashMap<Integer, String[]> toAddress,
            String subject, String htmlBody,String fromUn,
            Map<String, String> mapInlineImages) throws AddressException, MessagingException {
        
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.socketFactory.port", port); //SSL Port
        properties.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory"); 
        properties.put("mail.smtp.port", port);
        
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);

        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
        Message msg = new MimeMessage(session);

    //        try {
    //            msg.setFrom(new InternetAddress(userName,fromUn));
    //        } catch (UnsupportedEncodingException e) {
    //        }
        
    //        InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
    //        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(htmlBody, "text/html");
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        
        // adds inline image attachments
    //        System.out.println("size :"+mapInlineImages.size());
        if (mapInlineImages != null && mapInlineImages.size() > 0) {
            Set<String> setImageID = mapInlineImages.keySet();
             
            for (String contentId : setImageID) {
                MimeBodyPart imagePart = new MimeBodyPart();
                imagePart.setHeader("Content-ID", "<" + contentId + ">");
                imagePart.setDisposition(MimeBodyPart.INLINE);
    //           System.out.println("image content Id :"+contentId);
                String imageFilePath = mapInlineImages.get(contentId);
                try {
                    System.out.println("img path : "+mapInlineImages.get(contentId));
                    imagePart.attachFile(imageFilePath);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
        
                multipart.addBodyPart(imagePart);
            }
        }
        msg.setContent(multipart);
        try {
        //                System.out.println("UN :"+toAddress.get(i)[0]);
        //                htmlBody.replace("{_userName}", toAddress.get(i)[0]);
        //                messageBodyPart.setContent(htmlBody, "text/html");
        //                        multipart.addBodyPart(messageBodyPart);
        //                msg.setContent(multipart);
            msg.setFrom(new InternetAddress(userName,fromUn));
        } catch (UnsupportedEncodingException e) {
        }
        long b4 =  0; long aftr=0;
        b4 =  System. currentTimeMillis(); 
        for (int i=1;i<toAddress.size()+1;i++) {
         InternetAddress[] toAddresses = { new InternetAddress(toAddress.get(i)[1]) };
                msg.setRecipients(Message.RecipientType.TO, toAddresses);
        Transport.send(msg);
        }
            aftr =  System. currentTimeMillis(); 
            System.out.println(" time intrvl :"+(aftr-b4));
    }
}
