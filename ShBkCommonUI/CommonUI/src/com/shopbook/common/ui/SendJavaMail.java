package com.shopbook.common.ui;

import com.sun.mail.smtp.SMTPMessage;

import java.io.IOException;
import java.io.Serializable;

import java.io.UnsupportedEncodingException;

import java.security.SecureRandom;

import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
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

public class SendJavaMail implements Serializable{
    private String toEmail[], subject, body, smtpHostServer, fromEmail,replyTo,setFrom,
        paswrd, sslOrTls,smtpHostPort, fileName, imageEmail;
    private String[][][] myImg; private Map<String, String> mapInlineImages;

    public String genKey(int len) {
    char[] ch = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".toCharArray();
            char[] c = new char[len];
            SecureRandom random = new SecureRandom();
            for (int i = 0; i < len; i++) {
              c[i] = ch[random.nextInt(ch.length)];
            }
        return new String(c);
    }


    public void sendEmail(String host,String fromEmail,String fromPaswrd,
                                 Session session, String[] toEmail, String subject, String body){
        try {
            SMTPMessage msg = new SMTPMessage(session);
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.addHeader("format", "flowed");
            msg.addHeader("Content-Transfer-Encoding", "8bit");
            msg.setFrom(new InternetAddress(fromEmail,this.setFrom /*"Mymr"*/));
            msg.setReplyTo(InternetAddress.parse(this.replyTo/*"registeration@mymr.health"*/, false));
            msg.setSubject(subject, "UTF-8"); //   msg.setText(body, "UTF-8");
            msg.setContent(body, "text/html; charset=utf-8");
            msg.setSentDate(new Date());
           for (int i = 0; i < toEmail.length; i++) {
           msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail[i]));
           }
            System.out.println("Message is ready");
    //        Transport transport = null;

            try  { 
            System.out.println("Start connection");
                Transport transport = session.getTransport("smtp");
                transport.connect(host,fromEmail,fromPaswrd );
                transport.send(msg);
                transport.close();
            } catch (AddressException ae) {
            throw new MessagingException("Failed to send email : " + ae.getMessage(), ae);
                    }
            catch(MessagingException e) {           
            throw new MessagingException("Failed to send email : " + e.getMessage(), e);
              }
        } catch (Exception e) {
           // TODO: Add catch code
           e.printStackTrace();
    }
    }

    public void sendSsl() {
       
       final String fromEmail = this.getFromEmail(); //"myemailid@gmail.com"; requires valid gmail id
       final String password = this.getPaswrd();//"mypassword";  correct password for gmail id
       final String[] toEmail = this.getToEmail();//"myemail@yahoo.com";  can be any email id 
                     
                       System.out.println("SSLEmail Start");
                       Properties props = new Properties();
                       props.put("mail.smtp.host", this.getSmtpHostServer()/*"smtp.gmail.com"*/); //SMTP Host
                       props.put("mail.smtp.socketFactory.port", this.getSmtpHostPort()/*"465"*/); //SSL Port
                       props.put("mail.smtp.socketFactory.class",
                                       "javax.net.ssl.SSLSocketFactory"); //SSL Factory Class
                       props.put("mail.smtp.auth", "true"); //Enabling SMTP Authentication
                       props.put("mail.smtp.port", this.getSmtpHostPort()/*"465"*/); //SMTP Port
                       
                       Authenticator auth = new Authenticator() {
                               //override the getPasswordAuthentication method
                               protected PasswordAuthentication getPasswordAuthentication() {
                                       return new PasswordAuthentication(fromEmail, password);
                               }
                       };
                       
                       Session session = Session.getInstance(props, auth);
                       System.out.println("Session created");
       try {
    sendEmail(this.getSmtpHostServer(),fromEmail,password, session ,toEmail,this.getSubject(),this.getBody()/*"TLSEmail Testing Subject", "TLSEmail Testing Body"*/);
    //            sendAttachmentEmail(session, this.getToEmail() /*toEmail*/,
    //                                this.getSubject() /*"SSLEmail Testing Subject with Attachment"*/,
    //                                this.getBody() /*"SSLEmail Testing Body with Attachment"*/);
    //            sendImageEmail(session, this.getToEmail() /*toEmail*/,
    //                           this.getSubject() /*"SSLEmail Testing Subject with Image"*/,
    //                           this.getBody() /*"SSLEmail Testing Body with Image"*/);
       } catch (Exception e) {
           // TODO: Add catch code
           e.printStackTrace();
       }

    }
    
    public  void sendTls() {
                   final String fromEmail = this.getFromEmail(); //"myemailid@gmail.com"; requires valid gmail id
                   final String password = this.getPaswrd();//"mypassword";  correct password for gmail id
                   final String[] toEmail = this.getToEmail();//"myemail@yahoo.com";  can be any email id 
                   
                   System.out.println("TLSEmail Start");
                   Properties props = new Properties();
                   props.put("mail.smtp.host",this.getSmtpHostServer() /*"smtp.gmail.com"*/); //SMTP Host
                   props.put("mail.smtp.port",this.getSmtpHostPort() /*"587"*/); //TLS Port
                   props.put("mail.smtp.auth", "true"); //enable authentication
                   props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
                   //create Authenticator object to pass in Session.getInstance argument
                   Authenticator auth = new Authenticator() {
                           //override the getPasswordAuthentication method
                           protected PasswordAuthentication getPasswordAuthentication() {
                                   return new PasswordAuthentication(fromEmail, password);
                           }
                   };
                   Session session;
                   session = Session.getInstance(props, auth);
                   
    sendEmail(this.getSmtpHostServer(),fromEmail,password, session ,toEmail,this.getSubject(),this.getBody()/*"TLSEmail Testing Subject", "TLSEmail Testing Body"*/);
                   
           }
    public void customSend(){
       final String fromEmail = this.getFromEmail(); //"myemailid@gmail.com"; requires valid gmail id
       final String password = this.getPaswrd();//"mypassword";  correct password for gmail id
       final String[] toEmail = this.getToEmail();//"myemail@yahoo.com";  can be any email id 
       
       System.out.println("Custom Send Start");
       Properties props = new Properties();
       props.put("mail.smtp.host",this.getSmtpHostServer() /*"smtp.gmail.com"*/); //SMTP Host
       props.put("mail.smtp.port",this.getSmtpHostPort() /*"587"*/); //TLS Port
       props.put("mail.smtp.auth", "true"); //enable authentication
       props.put("mail.smtps.ssl.checkserveridentity", "false");
       props.put("mail.smtps.ssl.trust", "*");
       //create Authenticator object to pass in Session.getInstance argument
       Authenticator auth = new Authenticator() {
               //override the getPasswordAuthentication method
               protected PasswordAuthentication getPasswordAuthentication() {
                       return new PasswordAuthentication(fromEmail, password);
               }
       };
       Session session;
       session = Session.getInstance(props, auth);
       
       sendEmail(this.getSmtpHostServer(),fromEmail,password, session ,toEmail,this.getSubject(),this.getBody()/*"TLSEmail Testing Subject", "TLSEmail Testing Body"*/);

       
    }

    public void sendAttachmentEmail(Session session, String toEmail,String subject, String body){
        try{
                 MimeMessage msg = new MimeMessage(session);
                 msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
                     msg.addHeader("format", "flowed");
                     msg.addHeader("Content-Transfer-Encoding", "8bit");
                      
                     msg.setFrom(new InternetAddress(""/*"no_reply@example.com"*/, "NoReply-JD"));

                     msg.setReplyTo(InternetAddress.parse(""/*"no_reply@example.com"*/, false));

                     msg.setSubject(subject, "UTF-8");

                     msg.setSentDate(new Date());

                     msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
                      
                 // Create the message body part
                 BodyPart messageBodyPart = new MimeBodyPart();

                 // Fill the message
                 messageBodyPart.setText(body);
                 
                 // Create a multipart message for attachment
                 Multipart multipart = new MimeMultipart();

                 // Set text message part
                 multipart.addBodyPart(messageBodyPart);

                 // Second part is attachment
                 messageBodyPart = new MimeBodyPart();
                 String filename = this.getFileName();/*"abc.txt";*/
                 DataSource source = new FileDataSource(filename);
                 messageBodyPart.setDataHandler(new DataHandler(source));
                 messageBodyPart.setFileName(filename);
                 multipart.addBodyPart(messageBodyPart);

                 // Send the complete message parts
                 msg.setContent(multipart);

                 // Send message
                 Transport.send(msg);
                 System.out.println("EMail Sent Successfully with attachment!!");
              }catch (MessagingException e) {
                 e.printStackTrace();
              } catch (UnsupportedEncodingException e) {
                         e.printStackTrace();
                }
    }

    public void sendImageEmail(Session session, String toEmail,String subject, String body) {
        try{
                 MimeMessage msg = new MimeMessage(session);
                 msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
                     msg.addHeader("format", "flowed");
                     msg.addHeader("Content-Transfer-Encoding", "8bit");
                      
                     msg.setFrom(new InternetAddress(this.setFrom/*"no_reply@example.com"*/, "NoReply-JD"));
                    
                     msg.setReplyTo(InternetAddress.parse(this.replyTo/*"no_reply@example.com"*/, false));

                     msg.setSubject(subject, "UTF-8");

                     msg.setSentDate(new Date());

                     msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(""/*toEmail*/, false));
                      
                 // Create the message body part
                 BodyPart messageBodyPart = new MimeBodyPart();

                 messageBodyPart.setText(body);
                 
                 // Create a multipart message for attachment
                 Multipart multipart = new MimeMultipart();

                 // Set text message part
                 multipart.addBodyPart(messageBodyPart);

                 // Second part is image attachment
                 messageBodyPart = new MimeBodyPart();
                 String filename = this.getImageEmail();/*"image.png"*/;
                 DataSource source = new FileDataSource(filename);
                 messageBodyPart.setDataHandler(new DataHandler(source));
                 messageBodyPart.setFileName(filename);
                 //Trick is to add the content-id header here
                 messageBodyPart.setHeader("Content-ID", "image_id");
                 multipart.addBodyPart(messageBodyPart);

                 //third part for displaying image in the email body
                 messageBodyPart = new MimeBodyPart();
                 messageBodyPart.setContent("<h1>Attached Image</h1>" +
                                     "<img src='cid:image_id'>", "text/html");
                 multipart.addBodyPart(messageBodyPart);
                 
                 //Set the multipart message to the email message
                 msg.setContent(multipart);

                 // Send message
                 Transport.send(msg);
                 System.out.println("EMail Sent Successfully with image!!");
              }catch (MessagingException e) {
                 e.printStackTrace();
              } catch (UnsupportedEncodingException e) {
                         e.printStackTrace();
                }
    }

    public void sendInlineImgEmail(Map<String, String> mapInlineImages/*,String[][][] myImg*/) 
    throws AddressException, MessagingException {
        final String fromEmail = this.getFromEmail();
        final String password = this.getPaswrd();

        // sets SMTP server properties
        
        Properties properties = new Properties();
        properties.put("mail.smtp.host", this.getSmtpHostServer());
        properties.put("mail.smtp.port", this.getSmtpHostPort());
        properties.put("mail.smtp.auth", "true");
    //        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.user", this.getFromEmail());
        properties.put("mail.password", this.getPaswrd());
        
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
        
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail.toString(), false));
        
        msg.setSubject(subject);
        msg.setSentDate(new Date());
    // creates message part
          MimeBodyPart messageBodyPart = new MimeBodyPart();
          messageBodyPart.setContent(this.body, "text/html");
    // creates multi-part
          Multipart multipart = new MimeMultipart();
          multipart.addBodyPart(messageBodyPart);
    // My code to add inline messages 
        int e =3; int i =0;
    //          if ( e > 0)  {
    //          for (int i=0; i < e; i++)
              for (Map.Entry <String,String> cc : mapInlineImages.entrySet())
          {
              i++;
              String xx = "image"+Integer.toString(i);
             MimeBodyPart imagePart = new  MimeBodyPart();
             imagePart.setHeader("Content-ID","<" + xx + ">"); 
             imagePart.setDisposition(MimeBodyPart.INLINE);
    //             String imageFilePath = myImg[i][0][0];
            String imageFilePath = cc.getValue();
                  System.out.println(i);
    ////          }
    // adds inline image attachments
    //          if (mapInlineImages != null && mapInlineImages.size() > 0) {
    //              Set<String> setImageID = mapInlineImages.keySet();
    //              for (String contentId : setImageID) {
    //                  MimeBodyPart imagePart = new MimeBodyPart();
    //                    System.out.println("content-id is :"+contentId);
    //                      imagePart.setHeader("Content-ID", "<" + contentId + ">");
    //                      imagePart.setDisposition(MimeBodyPart.INLINE);
    //                      String imageFilePath = mapInlineImages.get(contentId);
                  try {
                     imagePart.attachFile(imageFilePath);
                 } catch (IOException ex) {
                     ex.printStackTrace();
                 }
                  multipart.addBodyPart(imagePart);
    //              }
          } //
        msg.setContent(multipart);
        Transport.send(msg);
        
    }



    public void setToEmail(String[] toEmail) {
       this.toEmail = toEmail;
    }

    public String[] getToEmail() {
       return toEmail;
    }

    public void setSubject(String subject) {
       this.subject = subject;
    }

    public String getSubject() {
       return subject;
    }

    public void setBody(String body) {
       this.body = body;
    }

    public String getBody() {
       return body;
    }

    public void setSmtpHostServer(String smtpHostServer) {
       this.smtpHostServer = smtpHostServer;
    }

    public String getSmtpHostServer() {
       return smtpHostServer;
    }

    public void setFromEmail(String fromEmail) {
       this.fromEmail = fromEmail;
    }

    public String getFromEmail() {
       return fromEmail;
    }

    public void setPaswrd(String paswrd) {
       this.paswrd = paswrd;
    }

    public String getPaswrd() {
       return paswrd;
    }

    public void setSslOrTls(String sslOrTls) {
       this.sslOrTls = sslOrTls;
    }

    public String getSslOrTls() {
       return sslOrTls;
    }

    public void setSmtpHostPort(String smtpHostPort) {
       this.smtpHostPort = smtpHostPort;
    }

    public String getSmtpHostPort() {
       return smtpHostPort;
    }

    public void setFileName(String fileName) {
       this.fileName = fileName;
    }

    public String getFileName() {
       return fileName;
    }

    public void setImageEmail(String imageEmail) {
       this.imageEmail = imageEmail;
    }

    public String getImageEmail() {
       return imageEmail;
    }

    public void setMyImg(String[][][] myImg) {
        this.myImg = myImg;
    }

    public String[][][] getMyImg() {
        return myImg;
    }

    public void setMapInlineImages(Map<String, String> mapInlineImages) {
        this.mapInlineImages = mapInlineImages;
    }

    public Map<String, String> getMapInlineImages() {
        return mapInlineImages;
    }


    public void setReplyTo(String replyTo) {
        this.replyTo = replyTo;
    }

    public String getReplyTo() {
        return replyTo;
    }

    public void setSetFrom(String setFrom) {
        this.setFrom = setFrom;
    }

    public String getSetFrom() {
        return setFrom;
    }
}
