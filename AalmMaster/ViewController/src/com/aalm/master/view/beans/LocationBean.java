package com.aalm.master.view.beans;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import java.io.Serializable;

import javax.faces.event.ActionEvent;

@ManagedBean(name="locationBean")
@ViewScoped
public class LocationBean {
    private double latitude;
    private double longitude;

    // Getters and setters
    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }

    public void updateLocation(ActionEvent actionEvent) {
        System.out.println("Updated location: lat=" + latitude + ", lng=" + longitude);
    }
}
