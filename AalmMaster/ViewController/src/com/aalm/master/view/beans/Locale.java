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
import javax.faces.application.Application;
import javax.faces.application.ViewHandler;
import javax.faces.component.UIViewRoot;
import javax.faces.context.FacesContext;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import oracle.adf.model.binding.DCIteratorBinding;

import org.apache.myfaces.trinidad.event.PollEvent;

public class Locale implements Serializable{
    private String locale;
    private String tm ;//= new Date().toString();


//    public void setTm(String tm) {
//        this.tm = new Date().toString();
//    }
//
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

}
