package com.aalm.hr.view.beans;

import com.shopbook.common.ui.ADFUtils;
import com.shopbook.common.ui.JSFUtil;

import com.shopbook.common.ui.FileUploadBean;

import java.io.File;

import java.sql.Timestamp;

import java.util.Date;

import java.util.Map;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.faces.event.ValueChangeEvent;

import oracle.adf.model.binding.DCIteratorBinding;
import oracle.adf.share.logging.ADFLogger;
import oracle.adf.view.rich.component.rich.RichPopup;
import oracle.adf.view.rich.component.rich.output.RichInlineFrame;

import oracle.adf.view.rich.event.DialogEvent;

import oracle.adfdt.model.objects.IteratorBinding;

import oracle.binding.OperationBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;

import org.apache.myfaces.trinidad.event.ReturnEvent;
import org.apache.myfaces.trinidad.model.UploadedFile;

public class HrBean {
    
    private FileUploadBean IdfileUploadBean;
    private FileUploadBean CerfileUploadBean;
    private FileUploadBean PerfileUploadBean;
    private FileUploadBean ConfileUploadBean;
    private RichInlineFrame imageInlineFrame;
    private RichInlineFrame CerimageInlineFrame;
    private RichInlineFrame ConimageInlineFrame;
    private RichInlineFrame PerimageInlineFrame;
    private String idPhotoPath = null;
    private String CerPhotoPath = null;
    private String ConPhotoPath = null;
    private String PerPhotoPath = null;
    private Integer contractId;
    private RichPopup attendanceConfirmationPopup;
    private Timestamp currentTime;
    private ADFLogger logger = ADFLogger.createADFLogger(HrBean.class);

    public HrBean() {
        IdfileUploadBean = new FileUploadBean();
        CerfileUploadBean = new FileUploadBean();
        PerfileUploadBean = new FileUploadBean();
        ConfileUploadBean = new FileUploadBean();

    }

    public String saveEmpContract() {
        // Add event code here...
//        if (this.idPhotoPath!=null) {
//            File ifFile = new File(this.idPhotoPath);
//            if(ifFile.delete()){
//                System.out.println("File deleted successfully.");   
//            }else  System.out.println("Failed to delete the file.");
//                
//        }
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findOperation("setCurrentRowWithKeyValue").execute();
        DCIteratorBinding ro = ADFUtils.findIterator("EmployeesVIterator");
        Row rws = ro.getCurrentRow();
        
        ro.getCurrentRow().setAttribute("IdNo",ADFUtils.getBoundAttributeValue("IdNo"));
        ro.getCurrentRow().setAttribute("EmpName",
                                        ADFUtils.getBoundAttributeValue("FirstName")+" "+
                                        ADFUtils.getBoundAttributeValue("MiddleName")+" "+
                                        ADFUtils.getBoundAttributeValue("LastName"));
        ro.getCurrentRow().setAttribute("ContractNo",ADFUtils.getBoundAttributeValue("ContractId"));
        ro.getCurrentRow().setAttribute("Salary",ADFUtils.getBoundAttributeValue("Salary"));
        ro.getCurrentRow().setAttribute("JobId",ADFUtils.getBoundAttributeValue("JobId1"));
        ro.getCurrentRow().setAttribute("CurrCode",ADFUtils.getBoundAttributeValue("CurrCode"));
        ro.getCurrentRow().setAttribute("OrgCode", ADFUtils.getBoundAttributeValue("OrgCode"));
//        System.out.println("org : "+ADFUtils.getBoundAttributeValue("OrgCode"));
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findOperation("Rollback").execute();
        return "toSave";
    }      
    
    public void contractsReturnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findOperation("setCurrentRowWithKeyValue").execute();   
    }
    
    public void idPhotoFileChange(ValueChangeEvent valueChangeEvent) {
        System.out.println("------"+valueChangeEvent.getNewValue());
        IdfileUploadBean.setFileserverPath(ADFUtils.getBoundAttributeValue("FileServerPath").toString());
        IdfileUploadBean.setMiddleName("IDs/");
        IdfileUploadBean.setFName(ADFUtils.getBoundAttributeValue("EmpId").toString());
        IdfileUploadBean.uploadFile(valueChangeEvent);
        ADFUtils.setBoundAttributeValue("IdPhotoPath", IdfileUploadBean.getUploadedFilePath().toString());
      }

    public void certificatePhotoFileChange(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
        System.out.println("------"+valueChangeEvent.getNewValue());
        CerfileUploadBean.setFileserverPath(ADFUtils.getBoundAttributeValue("FileServerPath").toString());
        CerfileUploadBean.setMiddleName("CERTs/");
        CerfileUploadBean.setFName(ADFUtils.getBoundAttributeValue("EmpId").toString());
        CerfileUploadBean.uploadFile(valueChangeEvent);
        ADFUtils.setBoundAttributeValue("CertificatePhotoPath", CerfileUploadBean.getUploadedFilePath().toString());

    }

    public void contractPhotoFileChange(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
        System.out.println("------");
        ConfileUploadBean.setFileserverPath(ADFUtils.getBoundAttributeValue("FileServerPath").toString());
        ConfileUploadBean.setMiddleName("CONTRACTs/");
        ConfileUploadBean.setFName(ADFUtils.getBoundAttributeValue("EmpId").toString());
        ConfileUploadBean.uploadFile(valueChangeEvent);
        ADFUtils.setBoundAttributeValue("ContractPhotoPath", ConfileUploadBean.getUploadedFilePath().toString());

    }
    
    public void personalPhotoFileChange(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
        System.out.println("------"+valueChangeEvent.getNewValue());
        PerfileUploadBean.setFileserverPath(ADFUtils.getBoundAttributeValue("FileServerPath").toString());
        PerfileUploadBean.setMiddleName("PERSONALs/");
        PerfileUploadBean.setFName(ADFUtils.getBoundAttributeValue("EmpId").toString());
        PerfileUploadBean.uploadFile(valueChangeEvent);
        ADFUtils.setBoundAttributeValue("PersonalPhotoPath", PerfileUploadBean.getUploadedFilePath().toString());

    }

    public void delIdPhoto(ActionEvent actionEvent) {
        // Add event code here...
//        File ifFile = new File(ADFUtils.getBoundAttributeValue("IdPhotoPath").toString());
        if (ADFUtils.getBoundAttributeValue("IdPhotoPath").toString()!=null) { //ifFile.delete()
            this.idPhotoPath=ADFUtils.getBoundAttributeValue("IdPhotoPath").toString();
            ADFUtils.setBoundAttributeValue("IdPhotoPath", null);
            this.imageInlineFrame.setSource("/images/NoImage.png");
                    System.out.println("File deleted successfully.");
                } else {
                    System.out.println("Failed to delete the file.");
                }
    }

    public void delCertificatePhoto(ActionEvent actionEvent) {
        // Add event code here...
    //        File ifFile = new File(ADFUtils.getBoundAttributeValue("IdPhotoPath").toString());
        if (ADFUtils.getBoundAttributeValue("CertificatePhotoPath").toString()!=null) { //ifFile.delete()
            this.CerPhotoPath=ADFUtils.getBoundAttributeValue("CertificatePhotoPath").toString();
            ADFUtils.setBoundAttributeValue("CertificatePhotoPath", null);
            this.CerimageInlineFrame.setSource("/images/NoImage.png");
                    System.out.println("File deleted successfully.");
                } else {
                    System.out.println("Failed to delete the file.");
                }
    }
    
    public void delPersonalPhoto(ActionEvent actionEvent) {
        // Add event code here...
    //        File ifFile = new File(ADFUtils.getBoundAttributeValue("IdPhotoPath").toString());
        if (ADFUtils.getBoundAttributeValue("PersonalPhotoPath").toString()!=null) { //ifFile.delete()
            this.PerPhotoPath=ADFUtils.getBoundAttributeValue("PersonalPhotoPath").toString();
            ADFUtils.setBoundAttributeValue("PersonalPhotoPath", null);
            this.PerimageInlineFrame.setSource("/images/NoImage.png");
                    System.out.println("File deleted successfully.");
                } else {
                    System.out.println("Failed to delete the file.");
                }
    }
    
    public void delContractPhoto(ActionEvent actionEvent) {
        // Add event code here...
    //        File ifFile = new File(ADFUtils.getBoundAttributeValue("IdPhotoPath").toString());
        if (ADFUtils.getBoundAttributeValue("ContractPhotoPath").toString()!=null) { //ifFile.delete()
            this.ConPhotoPath=ADFUtils.getBoundAttributeValue("ContractPhotoPath").toString();
            ADFUtils.setBoundAttributeValue("ContractPhotoPath", null);
            this.ConimageInlineFrame.setSource("/images/NoImage.png");
                    System.out.println("File deleted successfully.");
                } else {
                    System.out.println("Failed to delete the file.");
                }
    }

    public void applyApprovalActionLsnr(ActionEvent actionEvent) {
        // Add event code here...
        if(!ADFUtils.getBoundAttributeValue("ActionStatus").equals("PENDING")) {
    ADFUtils.findOperation("sp_handle_approval_action").execute();
//       ADFUtils.findIterator("ApprovalTransactionDetailsVOIterator").getViewObject().executeQuery();
        ADFUtils.findOperation("Rollback").execute();
        }
    }
    
    public String saveVacationActn() {
        // Add event code here...
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findOperation("sp_create_approval_transaction").execute();
        return "toSave";
    }    
    
    public String getUploadedFilePath() {
            return IdfileUploadBean.getUploadedFilePath();
        }
      
    public void refreshEmployeesRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findIterator("EmployeesVIterator").executeQuery();
        ADFUtils.findOperation("Rollback").execute();
    }
    
    public void setImageInlineFrame(RichInlineFrame imageInlineFrame) {
        this.imageInlineFrame = imageInlineFrame;
    }

    public RichInlineFrame getImageInlineFrame() {
        return imageInlineFrame;
    }
    
    public UploadedFile getUploadedFile() {
          return IdfileUploadBean.getUploadedFile();
      }

      public void setUploadedFile(UploadedFile file) {
          IdfileUploadBean.setUploadedFile(file);
      }
//--------------
    public UploadedFile getCerUploadedFile() {
          return CerfileUploadBean.getUploadedFile();
      }

      public void setCerUploadedFile(UploadedFile file) {
          CerfileUploadBean.setUploadedFile(file);
      }
      
    public UploadedFile getPerUploadedFile() {
          return PerfileUploadBean.getUploadedFile();
      }

      public void setPerUploadedFile(UploadedFile file) {
          PerfileUploadBean.setUploadedFile(file);
      }
      
    public UploadedFile getConUploadedFile() {
          return ConfileUploadBean.getUploadedFile();
      }

      public void setConUploadedFile(UploadedFile file) {
          ConfileUploadBean.setUploadedFile(file);
      }


    public void setCerimageInlineFrame(RichInlineFrame CerimageInlineFrame) {
        this.CerimageInlineFrame = CerimageInlineFrame;
    }

    public RichInlineFrame getCerimageInlineFrame() {
        return CerimageInlineFrame;
    }

    public void setConimageInlineFrame(RichInlineFrame ConimageInlineFrame) {
        this.ConimageInlineFrame = ConimageInlineFrame;
    }

    public RichInlineFrame getConimageInlineFrame() {
        return ConimageInlineFrame;
    }

    public void setPerimageInlineFrame(RichInlineFrame PerimageInlineFrame) {
        this.PerimageInlineFrame = PerimageInlineFrame;
    }

    public RichInlineFrame getPerimageInlineFrame() {
        return PerimageInlineFrame;
    }

    public void setContractId(Integer contractId) {
        this.contractId = contractId;
    }

    public Integer getContractId() {
        return contractId;
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
            ADFUtils.findIterator("AttendanceVIterator").executeQuery();
                } else {
                    ADFUtils.setBoundAttributeValue("CheckOutTime", this.getCurrentTime());
                    ADFUtils.findOperation("Commit").execute();
                    ADFUtils.findIterator("AttendanceVIterator").executeQuery();
                           break;
                }   case no:    // for type="yesNo"
                          System.out.println("User pressed NO - "+JSFUtil.getFromSession("attendance"));
                           break;
                       // If you ever use type="okCancel", check ok/cancel instead.
                       default:
                           logger.info("Dialog dismissed: " + e.getOutcome());
                   }
    }

    public void vacationDialogeLsnr(DialogEvent e) {
        // Add event code here...           
            switch (e.getOutcome()) {
                case ok:
                    System.out.println("User pressed OK");
                    ADFUtils.findOperation("Commit").execute();
                    break;

                case cancel:
                    System.out.println("User pressed Cancel");
                    ADFUtils.findOperation("Rollback").execute();
                    break;

                default:
                    logger.info("Dialog dismissed: " + e.getOutcome());
            }
        }

    public void setCurrentTime(Timestamp currentTime) {
        this.currentTime = currentTime;
    }

    public Timestamp getCurrentTime() {
        return new Timestamp(new Date().getTime());
    }
//    private String getLatitude() {
//        FacesContext facesContext = FacesContext.getCurrentInstance();
//        ExternalContext externalContext = facesContext.getExternalContext();
//        Map<String, Object> sessionMap = externalContext.getSessionMap();
//        return (String) sessionMap.get("latitude");
//    }
public String getLatitude() {
    FacesContext facesContext = FacesContext.getCurrentInstance();
    ExternalContext externalContext = facesContext.getExternalContext();
    Map<String, Object> sessionMap = externalContext.getSessionMap();

    // Print session ID for comparison
    Object session = externalContext.getSession(false);
    if (session instanceof javax.servlet.http.HttpSession) {
        javax.servlet.http.HttpSession httpSession =
            (javax.servlet.http.HttpSession) session;
        System.out.println("=== Destination page session ID: "
                           + httpSession.getId());
    }

    String lat = (String) sessionMap.get("latitude");
    System.out.println("=== latitude from session: " + lat);
    return lat;
}
    private String getLongitude() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        ExternalContext externalContext = facesContext.getExternalContext();
        Map<String, Object> sessionMap = externalContext.getSessionMap();
        return (String) sessionMap.get("longitude");
    }
    
    // Primary — Google Maps
    public String getGoogleMapUrl() {
        String latitude  = getLatitude();
        String longitude = getLongitude();

        if (latitude == null || longitude == null
            || latitude.equals("N/A") || longitude.equals("N/A")) {
            return "https://maps.google.com/maps?q=0,0&z=2&output=embed";
        }

                return "https://maps.google.com/maps?q="
                       + latitude + "," + longitude
                       + "&z=15&output=embed";
    }

    // Fallback — OpenStreetMap
    public String getOpenStreetMapUrl() {
        String latitude  = getLatitude();
        String longitude = getLongitude();

        if (latitude == null || longitude == null
            || latitude.equals("N/A") || longitude.equals("N/A")) {
            return "https://www.openstreetmap.org/export/embed.html"
                   + "?bbox=-180,-90,180,90&layer=mapnik";
        }

        double lat = Double.parseDouble(latitude);
        double lon = Double.parseDouble(longitude);

        return "https://www.openstreetmap.org/export/embed.html?bbox="
               + (lon - 0.01) + "," + (lat - 0.01) + ","
               + (lon + 0.01) + "," + (lat + 0.01)
               + "&layer=mapnik&marker="
               + lat + "," + lon;
    }

    public void saveTransferEmp(ActionEvent actionEvent) {
        // Add event code here...
        System.out.println("Full Time : " + JSFUtil.resolveExpressionAsBoolean("#{bindings.FullTime.inputValue}") +
                           "time : " + new Timestamp(System.currentTimeMillis()));
        ViewObject vo = ADFUtils.findIterator("EmployeeJobHistoryVIterator").getViewObject();

        if (JSFUtil.resolveExpressionAsBoolean("#{bindings.FullTime.inputValue}")) {
            vo.setWhereClause("to_dt is null and job_id <>" + ADFUtils.getBoundAttributeValue("JobId") + "");
            vo.executeQuery();
            Row[] rw = vo.getAllRowsInRange();
            for (Row r : rw) {
                System.out.println("index : " + r.getAttribute("FrmDt"));
                r.setAttribute("ToDt", new Timestamp(System.currentTimeMillis()));
            }
        }
        ADFUtils.setBoundAttributeValue("EmpJobId", ADFUtils.getBoundAttributeValue("JobId"));
        ADFUtils.findOperation("Commit").execute();
        vo.setWhereClause(null);
        vo.executeQuery();
    }
}
