package com.aalm.master.view.beans;

import com.shopbook.common.ui.ADFUtils;
import com.shopbook.common.ui.JSFUtil;

import oracle.adf.controller.ControllerContext;

import java.io.IOException;
import java.io.Serializable;

import javax.faces.component.UIComponent;
import javax.faces.component.UIViewRoot;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;

import oracle.adf.controller.ControllerContext;
import oracle.adf.controller.TaskFlowId;

import oracle.adf.view.rich.component.rich.RichPanelWindow;
import oracle.adf.view.rich.component.rich.RichPopup;

import oracle.adf.view.rich.component.rich.nav.RichCommandButton;
import oracle.adf.view.rich.component.rich.nav.RichLink;

import oracle.binding.OperationBinding;

public class AppsBean implements Serializable {

    private RichPopup sideMenuPopup;
    private String taskFlowId = "/WEB-INF/ErpAdmin/users-TF.xml#users-TF";
    private RichPopup noteWindowFncnPopup;
    private RichPopup uncommittedDataPopup;


    public TaskFlowId getDynamicTaskFlowId() {
//        System.out.println("from getDynamicTaskFlowId");
        return TaskFlowId.parse(taskFlowId);
    }

    public void setDynamicTaskFlowId(String taskFlowId) {
        this.taskFlowId = taskFlowId;
    }
    
    public void showFncnPopupActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        UIComponent source = actionEvent.getComponent();
       OperationBinding oper = ADFUtils.findOperation("ExecuteWithParams");
        oper.getParamsMap().put("pSystemId", JSFUtil.resolveExpression("#{roles.SystemId}"));
        oper.getParamsMap().put("pRoleGroupId", JSFUtil.resolveExpression("#{roles.RoleGroupId}"));
        System.out.println("--system id -- "+JSFUtil.resolveExpression("#{roles.SystemId}")+"--role group id-- "+
                        JSFUtil.resolveExpression("#{roles.RoleGroupId}")   );
        oper.execute();
        if (oper.getErrors().size()>0) {
            System.out.println("error id : "+oper.getErrors().size());
        }
        RichPopup.PopupHints hints = new RichPopup.PopupHints();
        hints.add(RichPopup.PopupHints.HintTypes.HINT_ALIGN_ID, source.getClientId())
                 .add(RichPopup.PopupHints.HintTypes.HINT_ALIGN, RichPopup.PopupHints.AlignTypes.ALIGN_AFTER_END);
        this.noteWindowFncnPopup.show(hints);
        
    }
//////////////////////// 

    public void hideSideMenuActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        this.sideMenuPopup.hide();
    }

    public void setSideMenuPopup(RichPopup sideMenuPopup) {
        this.sideMenuPopup = sideMenuPopup;
    }

    public RichPopup getSideMenuPopup() {
        return sideMenuPopup;
    }

    public void setNoteWindowFncnPopup(RichPopup noteWindowFncnPopup) {
        this.noteWindowFncnPopup = noteWindowFncnPopup;
    }

    public RichPopup getNoteWindowFncnPopup() {
        return noteWindowFncnPopup;
    }

    public void setUncommittedDataPopup(RichPopup uncommittedDataPopup) {
        this.uncommittedDataPopup = uncommittedDataPopup;
    }

    public RichPopup getUncommittedDataPopup() {
        return uncommittedDataPopup;
    }

    public void uncommittedDataYesActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        this.getUncommittedDataPopup().hide();
        ADFUtils.findOperation("Rollback").execute();
        JSFUtil.setExpressionValue("#{sessionScope.show_fncn}", false);
    }

    public void uncommittedDataNoActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        this.getUncommittedDataPopup().hide();
    }

///////////////////////
    public String onClickFncnActn() {
        // Add event code here...
        this.noteWindowFncnPopup.hide();
        this.sideMenuPopup.hide();

        if ((String) JSFUtil.resolveExpression("#{perms.TfLink}") != null) {
            JSFUtil.storeOnSession("refreshRegion", String.valueOf(System.currentTimeMillis()));
            this.setDynamicTaskFlowId((String) JSFUtil.resolveExpression("#{perms.TfLink}"));
            JSFUtil.storeOnSession("TaskFlowId", (String) JSFUtil.resolveExpression("#{perms.TfLink}"));
            JSFUtil.storeOnSession("show_fncn", true);
        }
        return null;
    }

    public String homeActn() {
        // Add event code here...
        if (ControllerContext.getInstance().getCurrentViewPort().isDataDirty()) {
            System.out.println("dirty data");
            RichPopup.PopupHints hints = new RichPopup.PopupHints();
            this.uncommittedDataPopup.show(hints);
        } else {
            JSFUtil.setExpressionValue("#{sessionScope.show_fncn}", false);
        }
        return null;
    }

    public String usersTF() {
        setDynamicTaskFlowId("/WEB-INF/ErpAdmin/users-TF.xml#users-TF");
        return null;
    }

    public String stndrdrolepermsTF() {
        setDynamicTaskFlowId("/WEB-INF/ErpAdmin/stndrd-role-perms-TF.xml#stndrd-role-perms-TF");
        return null;
    }

    public String currenciesTF() {
        setDynamicTaskFlowId("/WEB-INF/currencies/currencies-TF.xml#currencies-TF");
        return null;
    }

    public String itemCategoriesTF() {
        setDynamicTaskFlowId("/WEB-INF/itemCategories/itemCategories-TF.xml#itemCategories-TF");
        return null;
    }

    public String storeCategoriesTF() {
        setDynamicTaskFlowId("/WEB-INF/storeCategories/storeCategories-TF.xml#storeCategories-TF");
        return null;
    }

    public String organizationsTF() {
        setDynamicTaskFlowId("/WEB-INF/organizations/organizations-TF.xml#organizations-TF");
        return null;
    }

    public String unitstransformTF() {
        setDynamicTaskFlowId("/WEB-INF/units/units-transform-TF.xml#units-transform-TF");
        return null;
    }

    public String itemsTF() {
        setDynamicTaskFlowId("/WEB-INF/items/items-TF.xml#items-TF");
        return null;
    }

    public String employeesTF() {
        setDynamicTaskFlowId("/WEB-INF/employees/employees-TF.xml#employees-TF");
        return null;
    }

    public String jobsTF() {
        setDynamicTaskFlowId("/WEB-INF/jobs/jobs-TF.xml#jobs-TF");
        return null;
    }

    public String storeTF() {
        setDynamicTaskFlowId("/WEB-INF/stores/store-TF.xml#store-TF");
        return null;
    }

    public String customersTF() {
        setDynamicTaskFlowId("/WEB-INF/SLS/customers/customers-TF.xml#customers-TF");
        return null;
    }

    public String suppliersTF() {
        setDynamicTaskFlowId("/WEB-INF/suppliers/suppliers-TF.xml#suppliers-TF");
        return null;
    }

    public String clientsTF() {
        setDynamicTaskFlowId("/WEB-INF/clients/clients-TF.xml#clients-TF");
        return null;
    }

    public String mnf_process_basic_dataTF() {
        setDynamicTaskFlowId("/WEB-INF/Mnf-Process-basic-Data/mnf_process_basic_data-TF.xml#mnf_process_basic_data-TF");
        return null;
    }

    public String items_variables_structureTF() {
        setDynamicTaskFlowId("/WEB-INF/itemVariablesStructure/items_variables_structure-TF.xml#items_variables_structure-TF");
        return null;
    }

    public String gl_trans_typesTF() {
        setDynamicTaskFlowId("/WEB-INF/gl_trans_types/gl_trans_types-TF.xml#gl_trans_types-TF");
        return null;
    }

    public String gl_acc_typesTF() {
        setDynamicTaskFlowId("/WEB-INF/gl_acc_types/gl_acc_types-TF.xml#gl_acc_types-TF");
        return null;
    }

    public String gl_gen_acc_chartTF() {
        setDynamicTaskFlowId("/WEB-INF/gl_gen_acc_chart/gl_gen_acc_chart-TF.xml#gl_gen_acc_chart-TF");
        return null;
    }

    public String gl_org_cost_centersTF() {
        setDynamicTaskFlowId("/WEB-INF/gl_org_cost_centers/gl_org_cost_centers-TF.xml#gl_org_cost_centers-TF");
        return null;
    }

    public String gl_org_acc_chartTF() {
        setDynamicTaskFlowId("/WEB-INF/gl_org_acc_chart/gl_org_acc_chart-TF.xml#gl_org_acc_chart-TF");
        return null;
    }

    public String gl_financial_yearsTF() {
        setDynamicTaskFlowId("/WEB-INF/gl_financial_years/gl_financial_years-TF.xml#gl_financial_years-TF");
        return null;
    }

    public String rOgl_documentsTF() {
        setDynamicTaskFlowId("/WEB-INF/gl_documents/RO-gl_documents-TF.xml#RO-gl_documents-TF");
        return null;
    }

    public String setupDataTF() {
        setDynamicTaskFlowId("/WEB-INF/setupData/setupData-TF.xml#setupData-TF");
        return null;
    }

    public String transTypesTF() {
        setDynamicTaskFlowId("/WEB-INF/transTypes/transTypes-TF.xml#transTypes-TF");
        return null;
    }

    public String assets_basic_dataTF() {
        setDynamicTaskFlowId("/WEB-INF/assets_basic_data/assets_basic_data-TF.xml#assets_basic_data-TF");
        return null;
    }

    public String assetTransactionsTF() {
        setDynamicTaskFlowId("/WEB-INF/AssetTransactions/AssetTransactions-TF.xml#AssetTransactions-TF");
        return null;
    }

    public String projectsTF() {
        setDynamicTaskFlowId("/WEB-INF/projects/projects-TF.xml#projects-TF");
        return null;
    }

    public String setup_data() {
        setDynamicTaskFlowId("/WEB-INF/setup_data/setup_data.xml#setup_data");
        return null;
    }
}
