package com.aalm.hr.view.beans;

import com.shopbook.common.ui.ADFUtils;
import com.shopbook.common.ui.JSFUtil;

import com.shopbook.common.ui.FileUploadBean;

import java.io.File;

import javax.faces.event.ActionEvent;
import javax.faces.event.ValueChangeEvent;

import oracle.adf.model.binding.DCIteratorBinding;
import oracle.adf.view.rich.component.rich.output.RichInlineFrame;

import oracle.adfdt.model.objects.IteratorBinding;

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

    public HrBean() {
        IdfileUploadBean = new FileUploadBean();
        CerfileUploadBean = new FileUploadBean();
        PerfileUploadBean = new FileUploadBean();
        ConfileUploadBean = new FileUploadBean();

    }

    public void saveEmpContract(ActionEvent actionEvent) {
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
        ro.getCurrentRow().setAttribute("EmpName",ADFUtils.getBoundAttributeValue("FirstName")+" "+
          ADFUtils.getBoundAttributeValue("MiddleName")+" "+ADFUtils.getBoundAttributeValue("LastName"));
        ro.getCurrentRow().setAttribute("ContractNo",ADFUtils.getBoundAttributeValue("ContractId"));
        ro.getCurrentRow().setAttribute("Salary",ADFUtils.getBoundAttributeValue("Salary"));
        ro.getCurrentRow().setAttribute("JobId",ADFUtils.getBoundAttributeValue("JobId1"));
        ro.getCurrentRow().setAttribute("CurrCode",ADFUtils.getBoundAttributeValue("CurrCode"));
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findOperation("Rollback").execute();
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
}
