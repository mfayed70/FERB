package com.aalm.mnf.view.beans;

import com.shopbook.common.ui.ADFUtils;
import com.shopbook.common.ui.JSFUtil;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;

import oracle.binding.OperationBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;

import org.apache.myfaces.trinidad.event.ReturnEvent;

public class MnfBean {
    public MnfBean() {
    }


    public String createMnfPrcsStrMstr() {
        // Add event code here...
        if (!JSFUtil.resolveExpressionAsBoolean("#{row.bindings.IsComplex.inputValue}")) {
            ADFUtils.findOperation("CreateWithParamsPrcsStrPrnt").execute();
                JSFUtil.setExpressionValue("#{row.bindings.IsComplex.inputValue}", true);
        }
        return "toSelectProcess";
    }
    
    public String createMnfProcessStr() {
        // Add event code here...
        Integer _noOfrecs = 0;
    ViewObject vo = ADFUtils.findIterator("MnfProcessesTobeSelectedInStrVIterator").getViewObject();
        Row[] rws = vo.getFilteredRows("Selected","Y");
        if(rws.length>0) {
        for (Row r : rws) {
                System.out.println("row data : "+r.getAttribute("MnfPrcsId"));
            OperationBinding oper = ADFUtils.findOperation("CreateWithParamsPrcsStr");
            oper.getParamsMap().put("MnfPrcsId", r.getAttribute("MnfPrcsId"));
            oper.execute();
            }
            ADFUtils.findOperation("Commit").execute();
        return "toSave";
        } else return "toCancel";
    }

    public void refrshMnfProcessesRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        System.out.println("refresh");
        ADFUtils.findIterator("MnfProcessesVIterator").clearForRecreate();
        ADFUtils.findIterator("MnfProcessesVIterator").executeQuery();
        ADFUtils.findIterator("MnfProcessStructureVIterator").executeQuery();
    }

}
