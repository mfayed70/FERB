package com.aalm.master.view.beans;

import javax.faces.event.ActionEvent;
import oracle.adf.model.BindingContext;
import oracle.binding.BindingContainer;
import oracle.binding.AttributeBinding;
import com.shopbook.common.ui.*;

public class PunchAreaBean {

    private String locationStatus = "Not collected yet";

    public void onRefreshMap(ActionEvent actionEvent) {
        System.out.println("Map refresh triggered");
    }

    public String getMapUrl() {
        Integer vPid = (Integer) JSFUtil.resolveExpression("#{pageFlowScope.pId}");
        if (vPid != null) {
            
        }
        BindingContainer bindings =
            BindingContext.getCurrent()
                          .getCurrentBindingsEntry();

        AttributeBinding latBinding =
            (AttributeBinding) bindings.get("CenterLat");
        AttributeBinding lonBinding =
            (AttributeBinding) bindings.get("CenterLon");

        Object latObj = latBinding != null ?
                        latBinding.getInputValue() : null;
        Object lonObj = lonBinding != null ?
                        lonBinding.getInputValue() : null;

        if (latObj == null || lonObj == null) {
            return "https://www.openstreetmap.org/export/embed.html"
                   + "?bbox=-180,-90,180,90&layer=mapnik";
        }

        String latStr = latObj.toString();
        String lonStr = lonObj.toString();

        if (latStr.isEmpty()) {
            return "https://www.openstreetmap.org/export/embed.html"
                   + "?bbox=-180,-90,180,90&layer=mapnik";
        }

        double lat = Double.parseDouble(latStr);
        double lon = Double.parseDouble(lonStr);
        double delta = 0.003;

        return "https://www.openstreetmap.org/export/embed.html"
               + "?bbox="
               + (lon - delta) + "," + (lat - delta) + ","
               + (lon + delta) + "," + (lat + delta)
               + "&layer=mapnik&marker=" + lat + "," + lon;
    }

    public String getLocationStatus() { return locationStatus; }

    public void setLocationStatus(String locationStatus) {
        this.locationStatus = locationStatus;
    }
}