package com.shopbook.common.ui;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import java.util.Arrays;
import java.util.Date;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;

import javax.faces.event.ActionEvent;

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

public class SendEmail {
    // remember you can create an object of this class anywhere and then call whatever method yoy want to send email.
    
    private String toEmail,toEmails[], subject, body, smtpHostServer, fromEmail,
        paswrd, sslOrTls,smtpHostPort, fileName, imageEmail;
       private String[][][] myImg; private Map<String, String> mapInlineImages;
    
    // This method is example to send email from a method binded to such a method.
    
    public void sendTestEmail(ActionEvent actionEvent) {
        // Add event code here...
        /*this.getImageEmail();"image.png"*/;
                   int x = 4;
                   String[][] nn = new String[1][3];
                   for (int i=0;i<x;i++){
                     for (int j=0;j<3;j++) {
                         nn[0][j]= Integer.toString(i)+Integer.toString(j); 
                         } 
                     System.out.println(Arrays.deepToString(nn));
                   }                                            
               String xx= "<html>" +
               "<body>" +
               "<table width=\"50px\" height=\"50px\" cellpadding = \"2\" >" +
               "<tr><td align=\"center\" valign=\"center\"><a href=\"http://www.yahoo.com\">" +
                "<img src='cid:image_id' alt=\"description here\"></a><br />" +
          //      subArr[j]+
                "</td>" +
             //  "<td>Station Name</td>" +
               "</tr>" +
                 "</table>" +
                        "</body>" +
                        "</html>";
        SendEmail myEmail = new SendEmail();
        //myEmail.session;
        myEmail.setFromEmail("registeration@mymr.health");
        myEmail.setPaswrd("bIY,i_]jRAAK");
        //myEmail.setToEmail("mohd_fayed@yahoo.com");
        String[] toEmails = {"AAAA@yopmail.com","BBBB@yopmail.com","CCCC@yopmail.com"};
        myEmail.setSmtpHostServer("mail.mymr.health");
        myEmail.setSmtpHostPort("465");
        myEmail.setSubject("Test Subject");
        myEmail.setBody(xx);
     // inline images
     Map<String, String> inlineImages = new HashMap<String, String>();
            inlineImages.put("image1", "/home/mfayed/Pictures/1.jpeg");
            inlineImages.put("image2", "/home/mfayed/Pictures/2.jpeg");
            inlineImages.put("image3", "/home/mfayed/Pictures/3.jpeg");
               System.out.println("map size : "+inlineImages.size());

     StringBuffer body  = new StringBuffer("<html>This message contains inline images.<br>");
             body.append("<table cellpadding = \"1\" ><tr>");
             
             body.append("<td align=\"center\" valign=\"center\"><a href=\"http://www.yahoo.com\">");
             body.append("<img src=\"cid:image1\" width=\"100px\" height=\"100px\" ></a><br />");
             body.append("This one is a first image </td>");
             
             body.append("<td align=\"center\" valign=\"center\"><a href=\"http://www.yahoo.com\">");
             body.append("<img src=\"cid:image2\" width=\"100px\" height=\"100px\" ></a><br />");
             body.append("This one is a second image </td>");
             
             body.append("<td align=\"center\" valign=\"center\"><a href=\"http://www.yahoo.com\">");
             body.append("<img src=\"cid:image3\" width=\"100px\" height=\"100px\" ></a><br />");
             body.append("This one is a third image </td>");
            
             body.append("</tr></table></html>");
             
    myEmail.setMapInlineImages(inlineImages);
    myEmail.setBody(body.toString());
//    System.out.println(body.toString());
            try {
                for (String s : toEmails) {
                        //myEmail.setToEmails(s);
                    System.out.println("email :"+s.toString());
                        myEmail.sendInlineImgEmail(myEmail.getMapInlineImages()/*, myEmail.getMyImg()*/);
                        System.out.println("Email sent.");
                }   } catch (Exception ex) {
                        System.out.println("Could not send email.");
                        ex.printStackTrace();
                    }
               }

    public static void sendEmail //(Session session, String[] toEmails, String subject, String body)
    (String host,String fromEmail,String fromPaswrd,Session session, String[] toEmails, String subject, String body)
 throws Exception {
                    try
                {
                  MimeMessage msg = new MimeMessage(session);
                  //set message headers
                  msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
                  msg.addHeader("format", "flowed");
                  msg.addHeader("Content-Transfer-Encoding", "8bit");
                  msg.setFrom(new InternetAddress("no_reply@example.com", "NoReply-JD"));
                  msg.setReplyTo(InternetAddress.parse("no_reply@example.com", false));
                  msg.setSubject(subject, "UTF-8");//         msg.setText(body, "UTF-8");
                  msg.setContent(body, "text/html: charset=utf-8");
                  msg.setSentDate(new Date());
                    for (int i = 0; i < toEmails.length; i++) {
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails[i]));
                    }
                     System.out.println("Message is ready");                 
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
    
    public  void sendTls() {
                    final String fromEmail = this.getFromEmail(); //"myemailid@gmail.com"; requires valid gmail id
                    final String password = this.getPaswrd();//"mypassword";  correct password for gmail id
                    final String toEmails[] = this.getToEmails();//"myemail@yahoo.com";  can be any email id 
                    
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
                    Session session = Session.getInstance(props, auth);
                    try { 
               sendEmail(this.getSmtpHostServer(),fromEmail,password, session ,toEmails,this.getSubject(),this.getBody());
                    } catch (Exception e){
                      e.printStackTrace();
                    }
            }

    public void sendSsl() {
        final String fromEmail = this.getFromEmail();//"myemailid@gmail.com"; requires valid gmail id
                        final String password = this.getPaswrd();//"mypassword";  correct password for gmail id
                        final String toEmails[] = this.getToEmails();//"myemail@yahoo.com";  can be any email id 
                        
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
            sendEmail(this.getSmtpHostServer(),fromEmail,password, session ,toEmails,this.getSubject(),this.getBody());
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
    
    public void customSend(){
        final String fromEmail = this.getFromEmail(); //"myemailid@gmail.com"; requires valid gmail id
        final String password = this.getPaswrd();//"mypassword";  correct password for gmail id
        final String[] toEmails = this.getToEmails();//"myemail@yahoo.com";  can be any email id 
        
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
        try {
            sendEmail(this.getSmtpHostServer(),fromEmail,password, session ,toEmails,this.getSubject(),this.getBody());
        }catch (Exception e) {
            // TODO: Add catch code
            e.printStackTrace();
        }

        
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
                      
                     msg.setFrom(new InternetAddress(""/*"no_reply@example.com"*/, "NoReply-JD"));
                    
                     msg.setReplyTo(InternetAddress.parse(""/*"no_reply@example.com"*/, false));

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
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
        
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

    public void setImageEmail(String imageEmail) {
        this.imageEmail = imageEmail;
    }

    public String getImageEmail() {
        return imageEmail;
    }

 public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setToEmails(String[] toEmails) {
        this.toEmails = toEmails;
    }

    public String[] getToEmails() {
        return toEmails;
    }

//    public void setToEmail(String toEmail) {
//        this.toEmail = toEmail;
//    }
//
//    public String getToEmail() {
//        return toEmail;
//    }

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

}
