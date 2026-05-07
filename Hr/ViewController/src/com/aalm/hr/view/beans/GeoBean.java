package com.aalm.hr.view.beans;

import java.io.Serializable;
import java.util.Map;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import org.apache.myfaces.trinidad.event.PollEvent;

public class GeoBean implements Serializable {

    private String latitude;
    private String longitude;
    private String accuracy;
    private String locationStatus = "Detecting location...";
    private boolean locationReceived = false;
    private int pollInterval = 5000;

    public void onPoll(PollEvent pollEvent) {

                // If location already received
                // set interval to large number and do nothing
                if (locationReceived) {
                    pollInterval = 3600000;
                    return;
                }

                FacesContext facesContext = FacesContext.getCurrentInstance();
                ExternalContext externalContext = facesContext.getExternalContext();
        
        String accValue = externalContext.getRequestParameterMap().get("accHidden");
        String accLat = externalContext.getRequestParameterMap().get("latInput");
        String accLon = externalContext.getRequestParameterMap().get("lonInput");
        this.latitude = accLat;
        this.longitude = accLon;
        
                System.out.println(this.locationReceived+" - Poll fired: lat=" + this.latitude
                                 + " lon=" + this.longitude
                                 + " acc=" + accValue+ " - Interval"+this.pollInterval);

                if (this.latitude != null) {
                    if (!accValue.isEmpty()) {
                        this.accuracy = accValue;
                        locationReceived = true;
        
                        // Stop poll by setting interval to 1 hour
                        pollInterval = 3600000;
        
                        locationStatus = "Location detected. Accuracy: "
                                       + getFormattedAccuracy();
        
                        Map<String, Object> sessionMap =
                            externalContext.getSessionMap();
                        sessionMap.put("latitude",  this.latitude);
                        sessionMap.put("longitude", this.longitude);
                        sessionMap.put("accuracy",  this.accuracy);
                        System.out.println("from If :"+this.locationReceived+" - Poll fired: lat=" + this.latitude
                                         + " lon=" + this.longitude
                                         + " acc=" + accValue+ " - Interval"+this.pollInterval);
                    }
                }
    }

    public String getFormattedAccuracy() {
        if (accuracy == null) {
            return "Detecting...";
        }
        double acc = Double.parseDouble(accuracy);
        if (acc >= 1000) {
            long km = Math.round(acc / 1000);
            return km + " km (low accuracy)";
        }
        return Math.round(acc) + " meters";
    }

    public String getGoogleMapUrl() {
        if (latitude == null || longitude == null) {
            return "https://maps.google.com/maps?q=0,0"
                   + "&z=2&output=embed";
        }
        return "https://maps.google.com/maps?q="
               + latitude + "," + longitude
               + "&z=18&output=embed";
    }

    public String getOpenStreetMapUrl() {
        if (latitude == null || longitude == null) {
            return "https://www.openstreetmap.org/export/embed.html"
                   + "?bbox=-180,-90,180,90&layer=mapnik";
        }
        double lat = Double.parseDouble(latitude);
        double lon = Double.parseDouble(longitude);
        double delta = 0.001;
        if (accuracy != null) {
            double acc = Double.parseDouble(accuracy);
            double calculated = acc / 111000.0;
            if (calculated > delta) {
                delta = calculated;
            }
            if (delta > 0.05) {
                delta = 0.05;
            }
        }
        return "https://www.openstreetmap.org/export/embed.html"
               + "?bbox="
               + (lon - delta) + "," + (lat - delta) + ","
               + (lon + delta) + "," + (lat + delta)
               + "&layer=mapnik&marker=" + lat + "," + lon;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
    public String getLatitude()  { return latitude; }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
    public String getLongitude() { return longitude; }

    public void setAccuracy(String accuracy) {
        this.accuracy = accuracy;
    }
    public String getAccuracy()  { return accuracy; }

    public void setLocationStatus(String locationStatus) {
        this.locationStatus = locationStatus;
    }
    public String getLocationStatus() { return locationStatus; }

    public void setLocationReceived(boolean locationReceived) {
        this.locationReceived = locationReceived;
    }
    public boolean isLocationReceived() { return locationReceived; }

    public void setPollInterval(int pollInterval) {
        this.pollInterval = pollInterval;
    }
    public int getPollInterval() { return pollInterval; }
}