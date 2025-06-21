package com.aalm.center.view.beans;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.ConverterException;

public class ItemCodeConverter implements Converter {
    public Object getAsObject(FacesContext facesContext, UIComponent uIComponent, String string) {
        // TODO Implement this method
        String rtrn = null;
        if ( string != null )  {
        rtrn = string.toString().replaceAll("-", "");
//        System.out.println("string is : "+rtrn+" length :"+rtrn.length());
        return rtrn.toUpperCase();
    }
        else {
            return null;
        }
    }

    public String getAsString(FacesContext facesContext, UIComponent uIComponent, Object object) {
        // TODO Implement this method
        if (object != null) {
            String full="";
            String frst = object.toString().substring(0, 4)+"-";
            String scnd = object.toString().substring(4,8)+"-";
            String thrd = object.toString().substring(8);
//            System.out.println(frst+scnd+thrd);
            full=frst+scnd+thrd;
            return full.toUpperCase();
          } else {
            return null;
          }
    }
}
