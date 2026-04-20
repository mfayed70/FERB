package com.aalm.prcrmnt.view.beans;

import com.shopbook.common.ui.ADFUtils;

import oracle.adf.model.BindingContext;
import oracle.adf.model.binding.DCIteratorBinding;
import oracle.adf.view.rich.event.LaunchPopupEvent;

import oracle.adfdt.model.objects.IteratorBinding;

import oracle.binding.BindingContainer;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;

import oracle.jbo.uicli.binding.JUCtrlListBinding;

import org.apache.myfaces.trinidad.event.ReturnEvent;

public class PrcrmntClass {
    private String[] captions;
    public PrcrmntClass() {
    }

    public void refreshSuppliersRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findIterator("SuppliersVIterator").executeQuery();
    }

    public void itemsListLovLaunchLsnr(LaunchPopupEvent launchPopupEvent) {
        // Add event code here...
        BindingContainer bc = BindingContext.getCurrent().getCurrentBindingsEntry();
        DCIteratorBinding catIter = ADFUtils.findIterator("PurMatReqMastCatsVIterator");
        
        Integer catId = null;
        if (catIter.getCurrentRow() != null) {
        catId = (Integer) catIter.getCurrentRow().getAttribute("CatId");
        }
 // ⭐ get ListBinding (NOT iterator)
        
          JUCtrlListBinding listBinding =
               (JUCtrlListBinding) bc.get("ItemCode");

           ViewObject lovVO = listBinding.getViewObject();
            lovVO.setNamedWhereClauseParam("bindCatId", catId);
            lovVO.executeQuery();
      System.out.println("----"+catId);
      
//             getViewAccessorRS("ItemsLOV1").getViewObject();

//         lovVO.setNamedWhereClauseParam("bindCatId", catId);
//         lovVO.executeQuery();
    }
    public void initiateCaptions() {
        // Add event code here...
        ViewObject vo = ADFUtils.findIterator("ItemsVariablesForCaptionsVIterator").getViewObject();
        String[] myCaptions;
        myCaptions = new String[20];
        Row[] rw = vo.getAllRowsInRange();
        int i =0;
        for (Row r :rw ){
            myCaptions[i] = r.getAttribute("ColNameInItems").toString();
    //            System.out.println("------"+myCaptions[i]);
            i++;
        }
        this.setCaptions(myCaptions);
    }

    public void setCaptions(String[] captions) {
        this.captions = captions;
    }

    public String[] getCaptions() {
        return captions;
    }
}
