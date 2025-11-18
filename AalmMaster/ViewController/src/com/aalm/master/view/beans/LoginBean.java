package com.aalm.master.view.beans;

import com.shopbook.common.ui.ADFUtils;
import com.shopbook.common.ui.JSFUtil;

import java.sql.Timestamp;

import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

import javax.faces.event.ActionEvent;

import javax.servlet.http.HttpServletRequest;

import oracle.adf.share.logging.ADFLogger;

import oracle.adf.view.rich.component.rich.RichPopup;
import oracle.adf.view.rich.event.DialogEvent;

import oracle.binding.OperationBinding;

import oracle.jbo.Row;

import oracle.jbo.RowSetIterator;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;

public class LoginBean {
    private String userName;
    private String password;
    private ADFLogger logger = ADFLogger.createADFLogger(LoginBean.class);
//    private final String HOME_URL = "/AalM/erp/home"; //
    private final String HOME_URL = "/AalM/erp/userProfile";
    private final String LOGIN_URL = "/AalM/erp/login";
    private Timestamp currentTime;
    private RichPopup attendanceConfirmationPopup;
    private String pswrd, confrmPswrd;
    public String login() {
        // Add event code here...
                
        try {
            // attempt login
            SecurityUtils.getSubject().login(new UsernamePasswordToken(userName, password));
            // retrieve the saved request
            HttpServletRequest request =
                (HttpServletRequest) (FacesContext.getCurrentInstance().getExternalContext().getRequest());
            SavedRequest savedRequest = WebUtils.getAndClearSavedRequest(request);
            // get external context in order to redirect
            ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
            JSFUtil.storeOnSession("userEmail", this.userName);
            RowSetIterator rs = ADFUtils.findIterator("OrgUsersVIterator").getViewObject().createRowSetIterator(null);
            while (rs.hasNext()) {
                Row myRow = rs.next();
                JSFUtil.storeOnSession("userName",myRow.getAttribute("FirstName")+" "+
                                            myRow.getAttribute("LastName"));
                JSFUtil.storeOnSession("userId", myRow.getAttribute("UserId"));
                JSFUtil.storeOnSession("userMobile", myRow.getAttribute("Mobile"));
//                JSFUtil.storeOnSession("orgCode", myRow.getAttribute("OrgCode"));
                JSFUtil.storeOnSession("show_fncn", false);
            }
            ADFUtils.findIterator("OrgUsersVIterator").executeQuery();
         RowSetIterator userConOrgsrs =  ADFUtils.findIterator("UserInOrgVIterator").getViewObject().createRowSet(null);
             int x = (int) ADFUtils.findIterator("UserInOrgVIterator").getEstimatedRowCount();
//             int[] orgCodes;
//            orgCodes = new int[x];
            Integer orgCodes = null;
            while (userConOrgsrs.hasNext()){
                Row myRow = userConOrgsrs.next();
                System.out.println("indx : "+myRow.getAttribute("OrgCode"));
//    orgCodes[userConOrgsrs.getCurrentRowIndex()]= (Integer)myRow.getAttribute("OrgCode");  
                orgCodes = (Integer)myRow.getAttribute("OrgCode");
            }
            JSFUtil.storeOnSession("orgCode", orgCodes);
            System.out.println("org :"+JSFUtil.getFromSession("orgCode")+"--- "+x+" +++"+JSFUtil.getFromSession("orgCode").getClass());
            if (savedRequest != null) {
                if(request.getRequestURL().toString().contains("zamzam")){
                    JSFUtil.storeOnSession("orgIni", "z");
//                    System.out.println("header 1 :"+request.getRequestURL().toString());
                } else {
                    JSFUtil.storeOnSession("orgIni", "e");
//                    System.out.println("header 2 :"+request.getRequestURL().toString());
                } 
//                logger.fine("Retrieved saved URL '" + savedRequest.getRequestUrl() + "', redirecting");
//                externalContext.redirect(savedRequest.getRequestUrl());
            } else {
//                System.out.println("header :"+request.getRequestURL().toString());
                if(request.getRequestURL().toString().contains("zamzam")){
                    JSFUtil.storeOnSession("orgIni", "z");
//                    System.out.println("header 3 :"+request.getRequestURL().toString());
                } else {
                    JSFUtil.storeOnSession("orgIni", "e");
//                    System.out.println("header 4 :"+request.getRequestURL().toString());
                }
//                logger.fine("No URL retrieved, redirecting to HOME_URL: " + HOME_URL);
//                externalContext.redirect(HOME_URL);
            }
            System.out.println("user ID is :"+JSFUtil.getFromSession("userId"));
            ADFUtils.findOperation("createTodayAttendanceIfMissing").execute();
            ADFUtils.findIterator("UserAttendanceVIterator").executeQuery();
//            OperationBinding op = ADFUtils.findOperation("createTodayAttendanceIfMissing");
//            System.out.println(">>> Operation binding is " + (op == null ? "NULL" : "FOUND"));
//            
//            try {
//                op.execute();
//                if (!op.getErrors().isEmpty()) {
//                    System.out.println(">>> Errors during procedure call: " + op.getErrors());
//                } else {
//                    System.out.println(">>> Procedure executed without binding errors.");
//                }
//            } catch (Exception ex) {
//                ex.printStackTrace();
//            }
//            ADFUtils.findIterator("UserAttendanceVIterator").executeQuery();
//            RowSetIterator attIter = ADFUtils.findIterator("UserAttendanceVIterator").getRowSetIterator();
//            System.out.println(">>> Attendance rows count = " + attIter.getRowCount());
//            
            
            logger.fine("No URL retrieved, redirecting to HOME_URL: " + HOME_URL);
            externalContext.redirect(HOME_URL);
//            JSFUtil.storeOnSession("attendancePanel", false);
        } catch (AuthenticationException e) {
            logger.config("Failed login validation for user " + userName);
            FacesMessage msg =
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid username/password combination", "");
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (Exception e) {
            logger.warning("Unexpected error during login", e);
        }
        return null;
    }

    public void logOut(ActionEvent actionEvent) {
        // Add event code here...
        Subject currUser = SecurityUtils.getSubject();
        //HttpSession session=(HttpSession)FacesContext.getCurrentInstance().getExternalContext().getSession(false);
        currUser.logout();
        ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
        try {
            //          session.invalidate();
            externalContext.redirect(LOGIN_URL);

        } catch (Exception e) {
            // TODO: Add catch code
            e.printStackTrace();
            FacesContext.getCurrentInstance().addMessage(null,
                                                         new FacesMessage(FacesMessage.SEVERITY_ERROR, "Erro: ",
                                                                          e.getMessage()));
        }
    }

    public String setPswrdActn() {
        // Add event code here...
        JSFUtil.storeOnSession("userEmail", this.userName);
        ADFUtils.findOperation("ExecuteWithParams").execute();
        System.out.println("yes it exist" +
                           ADFUtils.findIterator("OrgUsersSetPasswordVIterator").getEstimatedRowCount() + " user :" +
                           JSFUtil.getFromSession("userEmail"));
        String rtrn = null;
        if (this.userName.contains("@")) {
            rtrn = "toForgotPswrd";
        } else {
            if (ADFUtils.findIterator("OrgUsersSetPasswordVIterator").getEstimatedRowCount() == 1) {
                rtrn = "setPassword";
            } else {
                JSFUtil.addFacesErrorMessage("Administrator should nullify your password");
                rtrn = null;
            }
        }
        return rtrn;
    }

    public String setNewPswrdActn() {
        // Add event code here...
        String actn = null;
        if (this.pswrd.equals(this.confrmPswrd)){
            ADFUtils.setBoundAttributeValue("Pswrd", this.pswrd);
            ADFUtils.findOperation("Commit").execute();

            JSFUtil.addFacesErrorMessage("Password set successfully");
            actn = "backToLogin";
        } else {
            JSFUtil.addFacesErrorMessage("Password mismatch");
            actn = null;
        }
        return actn;
    }


    public void nullifyPswrdActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.setBoundAttributeValue("Pswrd", null);
        ADFUtils.findOperation("Commit").execute();
        JSFUtil.addFacesInformationMessage("User password set null successfully");
    }
    
    public Date getCurrentDate() {
        return new Date();
    }

    public void setCurrentTime(Timestamp currentTime) {
        this.currentTime = currentTime;
    }

    public Timestamp getCurrentTime() {
        return new Timestamp(new Date().getTime());
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setLogger(ADFLogger logger) {
        this.logger = logger;
    }

    public ADFLogger getLogger() {
        return logger;
    }

    public void attendanceDialogLsnr(DialogEvent e) {
        // Add event code here...
            switch (e.getOutcome()) {
                       case yes:   // for type="yesNo"
            System.out.println("User pressed YES - "+JSFUtil.getFromSession("attendance"));
        System.out.println("curr time : "+this.getCurrentTime());
    if(JSFUtil.getFromSession("attendance").equals("Punch-in")) {
                    System.out.println("curr time : "+this.getCurrentTime());
            ADFUtils.setBoundAttributeValue("CheckInTime", this.getCurrentTime());
            ADFUtils.findOperation("Commit").execute();
            ADFUtils.findIterator("UserAttendanceVIterator").executeQuery();
                } else {
                    ADFUtils.setBoundAttributeValue("CheckOutTime", this.getCurrentTime());
                    ADFUtils.findOperation("Commit").execute();
                    ADFUtils.findIterator("UserAttendanceVIterator").executeQuery();
                           break;
                }   case no:    // for type="yesNo"
                          System.out.println("User pressed NO - "+JSFUtil.getFromSession("attendance"));
                           break;
                       // If you ever use type="okCancel", check ok/cancel instead.
                       default:
                           logger.info("Dialog dismissed: " + e.getOutcome());
                   }
    }

    public void punchinBtnActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
//        JSFUtil.storeOnSession("attendance", "Punch-in");
        RichPopup.PopupHints hints = new RichPopup.PopupHints();
        this.attendanceConfirmationPopup.show(hints);
    }

    public void punchoutBtnActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
//        JSFUtil.storeOnSession("attendance", "Punch-out");
        RichPopup.PopupHints hints = new RichPopup.PopupHints();
        this.attendanceConfirmationPopup.show(hints);
    }

    public void setAttendanceConfirmationPopup(RichPopup attendanceConfirmationPopup) {
        this.attendanceConfirmationPopup = attendanceConfirmationPopup;
    }

    public RichPopup getAttendanceConfirmationPopup() {
        return attendanceConfirmationPopup;
    }

    public void setPswrd(String pswrd) {
        this.pswrd = pswrd;
    }

    public String getPswrd() {
        return pswrd;
    }

    public void setConfrmPswrd(String confrmPswrd) {
        this.confrmPswrd = confrmPswrd;
    }

    public String getConfrmPswrd() {
        return confrmPswrd;
    }
}
