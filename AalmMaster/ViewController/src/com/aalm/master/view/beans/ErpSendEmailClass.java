package com.aalm.master.view.beans;

import com.shopbook.common.ui.ADFUtils;

import com.shopbook.common.ui.JSFUtil;
import com.shopbook.common.ui.SendEmail;

import javax.faces.event.ActionEvent;
import com.shopbook.common.ui.SendJavaMail;

import oracle.adf.view.rich.component.rich.input.RichInputText;

import oracle.binding.OperationBinding;

import org.apache.myfaces.trinidad.context.RequestContext;

public class ErpSendEmailClass {
    private RichInputText pswrd;
    private RichInputText confPswrd;

    public ErpSendEmailClass() {
    }

    public void sendVerifyEmail(ActionEvent actionEvent) {
        // Add event code here...
                
       SendJavaMail verifyEmail = new SendJavaMail();
        String xx = verifyEmail.genKey(128);
        ADFUtils.setBoundAttributeValue("Otp", xx);
        String org = ADFUtils.getBoundAttributeValue("EnOrgName")+" "+"ERP "+"Email Verification";
//        System.out.println("email :"+ADFUtils.getBoundAttributeValue("Email")+"--org :"+org);

        StringBuffer body  = new StringBuffer("<html><head><title>"+org+"</title></head>");
        body.append("<body><b>");
        body.append("Dear ");
        body.append("</b>");            
        body.append((String) ADFUtils.getBoundAttributeValue("FirstName")+" "+
                    (String) ADFUtils.getBoundAttributeValue("LastName"));
        body.append("<br><br>");
        body.append("You have registered as user on "+org);
        body.append("<br>");
        body.append("<br>");
        body.append("Please press ");
        body.append("<b>");
        body.append("<a href=");
        body.append((String) ADFUtils.getBoundAttributeValue("VerifyEmailUrl"));
        body.append(xx);
        body.append(">here</a></b>");
        body.append(" to verify your email.");
        body.append("");
//          System.out.println("link is :"+ADFUtils.getBoundAttributeValue("VerifyEmailUrl")+xx);
                body.append("<br><br>");
                body.append("<br><br>");
                body.append("Best regards");
                body.append("<br>");
                body.append(org+" Team</b>");
                body.append("</body></html>");

        System.out.println("body :"+body);
        verifyEmail.setBody(body.toString());
        verifyEmail.setSmtpHostServer((String) ADFUtils.getBoundAttributeValue("SmtpHost"));
        verifyEmail.setSmtpHostPort((String) ADFUtils.getBoundAttributeValue("SmtpPort"));
        verifyEmail.setFromEmail((String) ADFUtils.getBoundAttributeValue("AdminUsrname"));
        verifyEmail.setPaswrd((String) ADFUtils.getBoundAttributeValue("AdminPswrd"));
        verifyEmail.setSetFrom(org);
        verifyEmail.setReplyTo((String) ADFUtils.getBoundAttributeValue("AdminUsrname"));
        verifyEmail.setSubject("Please verify your email");
        verifyEmail.setToEmail(new String[] { (String) ADFUtils.getBoundAttributeValue("Email") });
        verifyEmail.customSend();
        ADFUtils.findOperation("Commit").execute();
    }

    public void varifyPswrd(ActionEvent actionEvent) {
        // Add event code here...
        String vPswrd = (String) this.pswrd.getLocalValue();
        String vConfPswrd = (String) this.confPswrd.getLocalValue();
        System.out.println(vPswrd + "---" + vConfPswrd);
        if (vPswrd == null || vConfPswrd == null || !vPswrd.equals(vConfPswrd) || vPswrd.length() < 6) {
            //       System.out.println("length :"+vPswrd.length());
            //        ADFUtils.setEL("#{pageFlowScope.pStatus}", "bad");
            JSFUtil.setExpressionValue("#{pageFlowScope.pStatus}", "bad");
            this.confPswrd.resetValue();
            this.pswrd.resetValue();
            RequestContext.getCurrentInstance().addPartialTarget(actionEvent.getComponent().getParent().getParent().getParent().getParent());
        } else {
            ADFUtils.setBoundAttributeValue("Pswrd", vPswrd);
            ADFUtils.setBoundAttributeValue("Otp", "");
            ADFUtils.findOperation("Commit").execute();
            JSFUtil.setExpressionValue("#{pageFlowScope.pStatus}", "good");
            RequestContext.getCurrentInstance().addPartialTarget(actionEvent.getComponent()
                                                                            .getParent()
                                                                            .getParent());

        }
    }
    
    public void setPswrd(RichInputText pswrd) {
        this.pswrd = pswrd;
    }

    public RichInputText getPswrd() {
        return pswrd;
    }

    public void setConfPswrd(RichInputText confPswrd) {
        this.confPswrd = confPswrd;
    }

    public RichInputText getConfPswrd() {
        return confPswrd;
    }

    public void CreateInsertUsrRolesMstr(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.findOperation("CreateInsertUsrRolesMstr").execute();
        ADFUtils.findOperation("CreateInsertUsrCntrlOrgs").execute();
    }
}
