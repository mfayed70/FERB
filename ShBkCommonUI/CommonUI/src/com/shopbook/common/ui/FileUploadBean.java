package com.shopbook.common.ui;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;

import org.apache.myfaces.trinidad.model.UploadedFile;

public class FileUploadBean {
    private UploadedFile uploadedFile;
    private String fileserverPath;
    private String middleName;
    private String fName;
    private String uploadedFilePath;

    public void setUploadedFile(UploadedFile uploadedFile) {
        this.uploadedFile = uploadedFile;
    }

    public UploadedFile getUploadedFile() {
        return uploadedFile;
    }

    public String getUploadedFilePath() {
        return uploadedFilePath;
    }


    public void setFileserverPath(String fileserverPath) {
        this.fileserverPath = fileserverPath;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public void setFName(String fName) {
        this.fName = fName;
    }

    public void uploadFile(ValueChangeEvent valueChangeEvent) {
        UploadedFile file = (UploadedFile) valueChangeEvent.getNewValue();
        String type = "";
        String vImgType = "";
            if (file.getContentType().equalsIgnoreCase("image/jpeg")) {
                type = "JPEG";
                vImgType = ".jpeg";
            } else if (file.getContentType().equalsIgnoreCase("image/png")) {
                type = "PNG";
                vImgType = ".png";
            } else if (file.getContentType().equalsIgnoreCase("image/bmp")) {
                type = "PNG";
                vImgType = ".png";
            } else if (file.getContentType().equalsIgnoreCase("image/gif")) {
                type = "GIF";
                vImgType = ".gif";
            }
        File fullPath = new File((String)this.fileserverPath.concat(this.middleName));
        System.out.println("---path---"+this.fileserverPath+"----"+fullPath+"-----"+file.getContentType());
        if(!fullPath.isDirectory()) {
            System.out.println("---make directory");
            fullPath.mkdirs();
        }
        if (file != null) {
            String destinationPath = this.fileserverPath+this.middleName+this.fName+vImgType;
                //"/home/mfayed/FERB/" + file.getFilename();
            File newFile = new File(destinationPath);
            try (

            FileOutputStream out = new FileOutputStream(newFile);
                InputStream inputStream = file.getInputStream()) {
               
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    uploadedFilePath = destinationPath;
                    FacesMessage msg = new FacesMessage("File uploaded: " + file.getFilename());
                    FacesContext.getCurrentInstance().addMessage(null, msg);
            
            } catch (IOException e) {
                FacesMessage msg = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Upload Failed", e.getMessage());
                FacesContext.getCurrentInstance().addMessage(null, msg);
            }
        } else System.out.println("---no File uploaded-----");
    }
}
