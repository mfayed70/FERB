package com.aalm.master.view.beans;

import com.shopbook.common.ui.ADFUtils;

import com.shopbook.common.ui.JSFUtil;

import java.io.Serializable;

import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import com.aalm.master.view.beans.AppsBean;

import java.util.Map;

import javax.faces.application.Application;
import javax.faces.application.ViewHandler;
import javax.faces.component.UIViewRoot;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;
import oracle.jbo.RowSetIterator;

import org.apache.myfaces.trinidad.event.PollEvent;
import javax.faces.component.UIComponent;

import oracle.adf.view.rich.context.AdfFacesContext;

public class Locale implements Serializable{
    private String locale;
    private String tm ;//= new Date().toString();
    private String latitude;
    private String longitude;
    private String accuracy;
    private String locationStatus = "Detecting location...";
    private boolean locationReceived = false;
    private int pollInterval = 3600000;
    private boolean locationValid = false;
    private Double distanceFromPunchArea;
    private String punchAreaName;
    private Double allowedRadius;
    
    public void onPoll(PollEvent pollEvent) {

        // If location already received
        // set interval to large number and do nothing
        if (locationReceived) {
            pollInterval = 3600000;
            return;
        }

        FacesContext facesContext = FacesContext.getCurrentInstance();
        ExternalContext externalContext = facesContext.getExternalContext();

        String accValue = externalContext.getRequestParameterMap()
                                         .get("accHidden");

        System.out.println(this.locationReceived+" - Poll fired: lat=" + this.latitude
                         + " lon=" + this.longitude
                         + " acc=" + accValue+ " - Interval"+this.pollInterval);

        if (accValue != null && !accValue.isEmpty()) {

            this.accuracy = accValue;
            locationReceived = true;
            pollInterval = 3600000;

            Map<String, Object> sessionMap =
                externalContext.getSessionMap();

            sessionMap.put("latitude", this.latitude);
            sessionMap.put("longitude", this.longitude);
            sessionMap.put("accuracy", this.accuracy);

            validatePunchLocation();

            System.out.println(
                "Location validation result: "
                + locationValid
                + " | Area: "
                + punchAreaName
                + " | Distance: "
                + distanceFromPunchArea
            );
        }

  /*      if (accValue != null) {
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
        } */
    }

    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {

        /*
         * Earth radius in meters.
         */
        final double EARTH_RADIUS = 6371000.0;

        /*
         * Convert the differences to radians.
         */
        double latDistance =
            Math.toRadians(lat2 - lat1);

        double lonDistance =
            Math.toRadians(lon2 - lon1);

        /*
         * Haversine formula.
         */
        double a =
            Math.sin(latDistance / 2)
            * Math.sin(latDistance / 2)
            + Math.cos(Math.toRadians(lat1))
            * Math.cos(Math.toRadians(lat2))
            * Math.sin(lonDistance / 2)
            * Math.sin(lonDistance / 2);

        double c =
            2 * Math.atan2(
                Math.sqrt(a),
                Math.sqrt(1 - a)
            );

        /*
         * Return distance in meters.
         */
        return EARTH_RADIUS * c;
    }
    
    private void validatePunchLocation() {

        locationValid = false;
        distanceFromPunchArea = null;
        punchAreaName = null;
        allowedRadius = null;

        RowSetIterator rs = null;
        System.out.println("org code is : "+JSFUtil.getFromSession("orgCode"));
        try {
            /*
             * Execute PunchArea VO using:
             * pOrgCode = sessionScope.orgCode
             */
            ADFUtils.findOperation("PunchAreaExecuteWithParams").execute();

            /*
             * Get the iterator after executing the query.
             */
            DCIteratorBinding iter =
                ADFUtils.findIterator("PunchAreaVIterator");

            rs = iter.getViewObject().createRowSetIterator(null);

            /*
             * Current employee location.
             */
            double currentLat = Double.parseDouble(latitude);
            double currentLon = Double.parseDouble(longitude);

            boolean insideAnyArea = false;

            while (rs.hasNext()) {
                System.out.println("inside loop: "+rs.getFetchedRowCount());
                Row row = rs.next();

                double centerLat =
                    ((Number) row.getAttribute("CenterLat")).doubleValue();

                double centerLon =
                    ((Number) row.getAttribute("CenterLon")).doubleValue();

                double radius =
                    ((Number) row.getAttribute("RadiusM")).doubleValue();

                String areaName =
                    (String) row.getAttribute("AreaName");

                /*
                 * Calculate the distance between the employee
                 * and the current registered punch area.
                 */
                double distance =
                    calculateDistance(
                        currentLat,
                        currentLon,
                        centerLat,
                        centerLon
                    );

                System.out.println(
                    "Checking Punch Area: " + areaName +
                    " | Distance = " + Math.round(distance) + " meters" +
                    " | Allowed Radius = " + Math.round(radius) + " meters"
                );

                /*
                 * Employee is inside this punch area.
                 */
                if (distance <= radius) {

                    insideAnyArea = true;

                    locationValid = true;
                    distanceFromPunchArea = distance;
                    allowedRadius = radius;
                    punchAreaName = areaName;

                    /*
                     * No need to check the remaining areas.
                     */
                    break;
                }
            }

            if (insideAnyArea) {

                locationStatus =
                    "You are inside the allowed work location: "
                    + punchAreaName
                    + ". Distance: "
                    + Math.round(distanceFromPunchArea)
                    + " meters.";

            } else {

                locationValid = false;

                locationStatus =
                    "You are outside all allowed work locations.";
            }

        } catch (Exception e) {

            locationValid = false;

            locationStatus =
                "Unable to validate your location.";

            e.printStackTrace();

        } finally {

            if (rs != null) {
                rs.closeRowSetIterator();
            }
        }
    }
    
    
    
    public void pollLsnr(PollEvent pollEvent) {
        // Add event code here...
  SimpleDateFormat dateFormat = new SimpleDateFormat("E, MMM dd yyyy HH:mm ,z");
        tm = dateFormat.format(new Date()).toString();
    }
    
    public String getTm() {
        return tm;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }

    public String getLocale() {
        if (locale == null) {
                   locale = FacesContext.getCurrentInstance().getViewRoot()
                       .getLocale().toString();
        JSFUtil.storeOnSession("lang", this.locale); 
        DCIteratorBinding iter = ADFUtils.findIterator("LanguageVIterator");
        iter.executeQuery();
//        ADFUtils.findIterator("ReferencesNamesVIterator").executeQuery();
    }
    return locale;
    }  
    //gets all the supported locals plus the default locale defined in the faces-config.xml
       //and add it to the list of selectItems
       public List<SelectItem> getLocales() {
           List<SelectItem> localList = new ArrayList<SelectItem>();
           Application application = FacesContext.getCurrentInstance().getApplication();
           Iterator supportedLocales = application.getSupportedLocales();
           while (supportedLocales.hasNext()) {
               java.util.Locale locale = (java.util.Locale) supportedLocales.next();
               localList.add(new SelectItem(locale.toString(), locale.getDisplayName(locale)));
           }
           java.util.Locale defaultLocale = application.getDefaultLocale();
           localList.add(new SelectItem(defaultLocale.toString(), defaultLocale.getDisplayName(defaultLocale)));
           return localList;
       }  
       
       private void changeLocale(String locale){
        this.locale = locale;
       java.util.Locale newLocale;
       newLocale = new java.util.Locale(this.locale);
       FacesContext context = FacesContext.getCurrentInstance();
       context.getViewRoot().setLocale(newLocale);
       
       String currentView = context.getViewRoot().getViewId();
       ViewHandler vh = context.getApplication().getViewHandler();
       UIViewRoot x = vh.createView(context, currentView);
       context.setViewRoot(x);
       JSFUtil.storeOnSession("refreshLocale", this.locale);
//       System.out.println("locale is : "+JSFUtil.getFromSession("refreshLocale"));
//       x.setViewId(context.getViewRoot().getViewId());
//       AppsBean xx = new AppsBean();
//       xx.setDynamicTaskFlowId((String) JSFUtil.getFromSession("#{perms.ArFncnDesc}"));
       }
       
       public void localeChangeListener(ValueChangeEvent valueChangeEvent) {
        changeLocale(valueChangeEvent.getNewValue().toString());
        JSFUtil.storeOnSession("lang", this.locale);
        DCIteratorBinding iter = ADFUtils.findIterator("LanguageVIterator");
        iter.executeQuery();
       // System.out.println(this.locale.toString());
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

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setAccuracy(String accuracy) {
        this.accuracy = accuracy;
    }

    public String getAccuracy() {
        return accuracy;
    }

    public void setLocationStatus(String locationStatus) {
        this.locationStatus = locationStatus;
    }

    public String getLocationStatus() {
        return locationStatus;
    }

    public void setLocationReceived(boolean locationReceived) {
        this.locationReceived = locationReceived;
    }

    public boolean isLocationReceived() {
        return locationReceived;
    }

    public void setPollInterval(int pollInterval) {
        this.pollInterval = pollInterval;
    }

    public int getPollInterval() {
        return pollInterval;
    }


    public boolean isLocationValid() {
        return locationValid;
    }

    public Double getDistanceFromPunchArea() {
        return distanceFromPunchArea;
    }

    public String getPunchAreaName() {
        return punchAreaName;
    }

    public Double getAllowedRadius() {
        return allowedRadius;
    }
}
