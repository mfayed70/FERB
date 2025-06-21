package com.aalm.master.view.beans;

import com.shopbook.common.ui.ADFUtils;

import com.shopbook.common.ui.JSFUtil;

import javax.faces.event.ValueChangeEvent;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;

import org.apache.myfaces.trinidad.event.ReturnEvent;

public class ErpAdminClass {
    public ErpAdminClass() {
    }

    public String saveGrantedRoles() {
        // Add event code here...
        String rtrn= "toSave";
        ViewObject voSys = ADFUtils.findIterator("NonGrantedRolesSyssVIterator").getViewObject();
        Row[] rwsSys = voSys.getAllRowsInRange(); //getFilteredRows("SelectedSys", true);
        for (Row rSys : rwsSys) {
            voSys.setCurrentRow(rSys);
        ViewObject vo = ADFUtils.findIterator("NonGrantedSysFncnsVIterator").getViewObject();
        Row[] rws = vo.getFilteredRows("SelectedFncn", true);
            if(rws.length>0){
ADFUtils.findOperation("CreateWithParamsSys").getParamsMap().put("SystemId", rSys.getAttribute("SystemId"));
                ADFUtils.findOperation("CreateWithParamsSys").execute();
            }
System.out.println("master row :"+rSys.getAttribute("SystemId")+"det rows :"+rws.length);
        for (Row r : rws) {
        System.out.println("row data : "+r.getAttribute("FncnId"));
ADFUtils.findOperation("CreateWithParamsFncn").getParamsMap().put("SystemId", rSys.getAttribute("SystemId"));
ADFUtils.findOperation("CreateWithParamsFncn").getParamsMap().put("FncnId", r.getAttribute("FncnId"));
ADFUtils.findOperation("CreateWithParamsFncn").execute();

                       }
        }
        return rtrn;
    }

    public String delRoleFncnActnLsnr() {
        // Add event code here...
        
        ViewObject voFncn = ADFUtils.findIterator("PermissionsVIterator").getViewObject();
Row[] rwsFncn = voFncn.getFilteredRows("SystemId", ADFUtils.findIterator("PermissionsVIterator").getViewObject().getCurrentRow().getAttribute("SystemId"));
//        System.out.println("curr row :"+currSysRow);
        ADFUtils.findOperation("DeletePermission").execute();
      
        System.out.println("no of recs :"+rwsFncn.length);
        if (rwsFncn.length==1) {
            ADFUtils.findOperation("DeleteSys").execute();
        }
        return null;
    }

    public void grantRolesRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findIterator("RoleMasterVIterator").executeQuery();
      Object obj = JSFUtil.resolveExpression("#{pageFlowScope.pGrpRolId}");
ADFUtils.findIterator("RoleMasterVIterator").setCurrentRowWithKeyValue(obj.toString());
    }
}
