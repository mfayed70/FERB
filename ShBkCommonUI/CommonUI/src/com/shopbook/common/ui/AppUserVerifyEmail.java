package com.shopbook.common.ui;

import java.security.SecureRandom;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

public class AppUserVerifyEmail {
    public AppUserVerifyEmail() {
        super();
    }
    private int len;
    
    public String genKey(int len) {
    char[] ch = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".toCharArray();
            char[] c = new char[len];
            SecureRandom random = new SecureRandom();
            for (int i = 0; i < len; i++) {
              c[i] = ch[random.nextInt(ch.length)];
            }
        return new String(c);
    }
    
    public void sendVerificationEmail (String toUser, String toEmail[], String to, String _url ) {
        String xx = genKey(128);
String url ="http://127.0.0.1:7101/shopbbokHome/shop/adf.task-flow?adf.tfDoc=%2FWEB-INF%2Freset-pwd-tf.xml&adf.tfId=reset-pwd-tf&pOneTimeCode=";
        ADFUtils.setBoundAttributeValue("OneTimeCode", xx);
        ADFUtils.setBoundAttributeValue("Passwrd", null);
        String toR = "Reference to your request to reset your password,";
        String toV = "Reference to your request to receive our news feed,";
        SendEmail verifEmail = new SendEmail();
        verifEmail.setSubject("Shopbook Verification Email");
        StringBuffer body  = new StringBuffer("<html><head><title>Email Verification</title></head>");
        body.append("<body><b>");
        body.append("Dear  ");
        body.append(toUser);
        body.append("</b>");
        body.append("<br><br>");
        if (to=="R") {
        body.append(toR);
        } else { body.append(toV); }
        body.append("<br>");
        body.append("Kindly verify your email by pressing ");
        body.append("<b>");
        body.append("<a href=");
        body.append(_url);
        body.append(xx);
        body.append(">Here</a></b>");
        body.append("<br><br>");
        body.append("<br><br><b>");
        body.append("Best Regards");
        body.append("<br><br>");
        body.append("Shopbook Team</b>");
        body.append("</body></html>");
        verifEmail.setBody(body.toString());
        verifEmail.setSmtpHostServer(ADFUtils.getBoundAttributeValue("SmtpHost").toString());
        verifEmail.setSmtpHostPort(ADFUtils.getBoundAttributeValue("SmtpPort").toString());
        verifEmail.setFromEmail(ADFUtils.getBoundAttributeValue("ShopAdminEmail").toString());
        verifEmail.setPaswrd(ADFUtils.getBoundAttributeValue("ShopAdminPasswrd").toString());
        verifEmail.setToEmails(toEmail);
        verifEmail.sendSsl();
//        FacesContext.getCurrentInstance().addMessage(
//                                                null,
//                                                new FacesMessage(FacesMessage.SEVERITY_WARN,
//                                                                "Incorrect Username and Passowrd",
//                                                                "Please enter correct username and Password"));
//
    }
    public static void main(String[] args) {
        AppUserVerifyEmail appUserVerifyEmail = new AppUserVerifyEmail();
    }

    public void setLen(int len) {
        this.len = len;
    }

    public int getLen() {
        return len;
    }
}
