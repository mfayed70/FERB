package com.aalm.assets.view.beans;

import com.shopbook.common.ui.ADFUtils;

import javax.faces.event.ActionEvent;

import oracle.binding.OperationBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;

public class AssetsBean {
    public AssetsBean() {
    }

    public void saveAddedProperties(ActionEvent actionEvent) {
        // Add event code here...
        ViewObject vo = ADFUtils.findIterator("AssetPropertiesLOVIterator").getViewObject();
        Row[] rws = vo.getFilteredRows("Selected", "Y");
        System.out.println("rows : "+rws.length);
        for (Row r : rws) {
            System.out.println("row data : "+r.getAttribute("Selected"));
       OperationBinding oper = ADFUtils.findOperation("CreateWithParams");
            oper.getParamsMap().put("AssPropId", r.getAttribute("AssPropId"));
            oper.execute();
                        }     
    }

    public void saveAddSpareParts(ActionEvent actionEvent) {
        // Add event code here...
        ViewObject vo = ADFUtils.findIterator("AssetsAllSparaPartsVIterator").getViewObject();
        Row[] rws = vo.getFilteredRows("Selected", "Y");
        for (Row r : rws) {
            System.out.println("row data : "+r.getAttribute("Selected"));
            OperationBinding oper = ADFUtils.findOperation("CreateWithParams");
                 oper.getParamsMap().put("ItemCode", r.getAttribute("ItemCode"));
                 oper.execute();
                        }
    }
}
