package com.aalm.gl.view.beans;

import com.shopbook.common.ui.*;

import java.io.Serializable;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.Iterator;

import java.util.List;

import java.util.Locale;

import javax.el.ELContext;

import javax.el.ExpressionFactory;

import javax.el.MethodExpression;

import javax.el.ValueExpression;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.context.FacesContextFactory;
import javax.faces.event.ActionEvent;

import javax.faces.event.ValueChangeEvent;

import javax.sql.RowSet;

import oracle.adf.view.rich.component.rich.RichPopup;
import oracle.adf.view.rich.component.rich.data.RichListItem;
import oracle.adf.view.rich.component.rich.data.RichListView;
import oracle.adf.view.rich.component.rich.data.RichTreeTable;

import oracle.adf.view.rich.component.rich.input.RichInputText;
import oracle.adf.view.rich.context.AdfFacesContext;

import oracle.binding.OperationBinding;

import oracle.jbo.Row;
import oracle.jbo.RowSetIterator;
import oracle.jbo.ViewObject;
import oracle.jbo.uicli.binding.JUCtrlHierNodeBinding;

import org.apache.myfaces.trinidad.event.ReturnEvent;
import org.apache.myfaces.trinidad.event.RowDisclosureEvent;
import org.apache.myfaces.trinidad.event.SelectionEvent;
import org.apache.myfaces.trinidad.model.RowKeySet;

public class GlBean implements Serializable {
    private RichTreeTable genericGlAccChart;
    private RichTreeTable costCenterTree;
    private RichTreeTable orgGlAccChartTree;

    public GlBean() {
    }

    public void delAccFromChartTreeActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        System.out.println("acc no :"+JSFUtil.resolveExpression("#{node.AccCode}")+
            "====="+JSFUtil.resolveExpression("#{node.PrntAccCode}"));
        RichTreeTable treeTable = this.getGenericGlAccChart();
        RowKeySet rks = treeTable.getSelectedRowKeys();
        Iterator keys = rks.iterator();
        while(keys.hasNext())   {
            List key = (List) keys.next();
            treeTable.setRowKey(key);
            JUCtrlHierNodeBinding node = (JUCtrlHierNodeBinding) treeTable.getRowData();
            Row rw = node.getRow();
            rw.remove();
            AdfFacesContext.getCurrentInstance().addPartialTarget(treeTable);
        }
    }

    public void delAccFromOrgAccTreeActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        RichTreeTable treeTable = this.getOrgGlAccChartTree();
        RowKeySet rks = treeTable.getSelectedRowKeys();
        Iterator keys = rks.iterator();
        while(keys.hasNext())   {
            List key = (List) keys.next();
            treeTable.setRowKey(key);
            JUCtrlHierNodeBinding node = (JUCtrlHierNodeBinding) treeTable.getRowData();
            Row rw = node.getRow();
            rw.remove();
            AdfFacesContext.getCurrentInstance().addPartialTarget(treeTable);
        }
    }
    

    public void delCostCenterFromTree(ActionEvent actionEvent) {
        // Add event code here...
        System.out.println("CC no :"+JSFUtil.resolveExpression("#{node.CostCenterCode}")+
            "====="+JSFUtil.resolveExpression("#{node.PrntCostCenterCode}"));
        RichTreeTable treeTable = this.getCostCenterTree();
        RowKeySet rks = treeTable.getSelectedRowKeys();
        Iterator keys = rks.iterator();
        while(keys.hasNext())   {
            List key = (List) keys.next();
            treeTable.setRowKey(key);
            JUCtrlHierNodeBinding node = (JUCtrlHierNodeBinding) treeTable.getRowData();
            Row rw = node.getRow();
            rw.remove();
            AdfFacesContext.getCurrentInstance().addPartialTarget(treeTable);
        }
    }

    public String glOrgChartCrudSaveBtnActnLsnr() {
        // Add event code here...
        String rtrn=null;
        System.out.println("---"+ADFUtils.getBoundAttributeValue("GlAssTblId1"));
        if(ADFUtils.getBoundAttributeValue("GlAssTblId1")!=null) {
            ADFUtils.findOperation("Commit").execute();
            OperationBinding oper = ADFUtils.findOperation("create_gl_assistance_from_tables");
            oper.getParamsMap().put("vAccCode", Integer.valueOf(ADFUtils.getBoundAttributeValue("AccCode").toString()));
            System.out.println("---"+ADFUtils.getBoundAttributeValue("TblNameE"));
            oper.getParamsMap().put("vTblName", ADFUtils.getBoundAttributeValue("GlAssTblId1"));
            oper.execute();
            rtrn="toSave";
        } else if (ADFUtils.getBoundAttributeValue("GlAssTblId1")==null)
        {
            ViewObject vo = ADFUtils.findIterator("GlAccAssistancesVIterator").getViewObject();
            System.out.println("acc code :"+ADFUtils.getBoundAttributeValue("AccCode"));
               Row[] rws = vo.getFilteredRows("AccCode", ADFUtils.getBoundAttributeValue("AccCode"));
               for (Row r : rws) {
                 System.out.println("row data : "+r.getAttribute("AccCode"));
                   r.remove();
               }
        ADFUtils.setBoundAttributeValue("GlAssTblId1", null);
                ADFUtils.findOperation("Commit").execute();
            rtrn= "toSave";
            
        }
        return rtrn;
    }

    public void refreshGlTransTypesTbl(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findIterator("GlTransTypesVIterator").executeQuery();
    }

    public void refreshGlGenAccChartTbl(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findIterator("GlGenAccChartVIterator").executeQuery();
    }

    public void refreshGlCostCenterTbl(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findIterator("GlCostCentersVIterator").executeQuery();
    }


    public void refreshGlOrgAccChartRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        RichTreeTable treeTable = this.getOrgGlAccChartTree();
    
        ADFUtils.findIterator("GlOrgAccChartVIterator").executeQuery();
    }
    
    public void setGenericGlAccChart(RichTreeTable genericGlAccChart) {
        this.genericGlAccChart = genericGlAccChart;
    }

    public RichTreeTable getGenericGlAccChart() {
        return genericGlAccChart;
    }

    public void setCostCenterTree(RichTreeTable costCenterTree) {
        this.costCenterTree = costCenterTree;
    }

    public RichTreeTable getCostCenterTree() {
        return costCenterTree;
    }

    public void setOrgGlAccChartTree(RichTreeTable orgGlAccChartTree) {
        this.orgGlAccChartTree = orgGlAccChartTree;
    }

    public RichTreeTable getOrgGlAccChartTree() {
        return orgGlAccChartTree;
    }

    public void CreditChngListener(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
        UIComponent comp = valueChangeEvent.getComponent();
                          comp.processUpdates(FacesContext.getCurrentInstance());

          if (valueChangeEvent.getNewValue()==null) {
              ADFUtils.setBoundAttributeValue("Credit","0000.00");                      
          }
       else if(!valueChangeEvent.getNewValue().toString().equals(0)){
       ADFUtils.setBoundAttributeValue("Debit","0000.00");
       }       
        if(ADFUtils.getBoundAttributeValue("SumDebit").equals(ADFUtils.getBoundAttributeValue("SumCredit"))){
            ADFUtils.setBoundAttributeValue("BalanceFlag1","Y");
        } else ADFUtils.setBoundAttributeValue("BalanceFlag1","N");
   }
    
    public void DeditChngListener(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
        UIComponent comp = valueChangeEvent.getComponent();
                          comp.processUpdates(FacesContext.getCurrentInstance());

        if (valueChangeEvent.getNewValue()==null){
            ADFUtils.setBoundAttributeValue("Debit", "0000.00");
        }
        else if(!valueChangeEvent.getNewValue().toString().equals(0)){
        ADFUtils.setBoundAttributeValue("Credit","0000.00");
        }
        if(ADFUtils.getBoundAttributeValue("SumDebit").equals(ADFUtils.getBoundAttributeValue("SumCredit"))){
            ADFUtils.setBoundAttributeValue("BalanceFlag1","Y");
        } else ADFUtils.setBoundAttributeValue("BalanceFlag1","N");
    }


    public String postGlDoc() {
        // Add event code here...
            ADFUtils.findOperation("Commit").execute();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.ENGLISH);
            DateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");          
        try {
            Date date = formatter.parse(ADFUtils.getBoundAttributeValue("GlDocDt").toString());
            String dt = targetFormat.format(date);
        ViewObject jrnlVo = ADFUtils.findIterator("GlJournalsVIterator").getViewObject();
//        System.out.println("journal records :"+jrnlVo.getEstimatedRowCount());
        Row[] rw = jrnlVo.getAllRowsInRange();
        for (Row r :rw) {
//System.out.println(r.getAttribute("AccCode"));//+"--"+dt+"--"+r.getAttribute("CurrCode")+"--"+r.getAttribute("Debit")+"--"+r.getAttribute("Credit"));            
            OperationBinding oper = ADFUtils.findOperation("gl_posting");
//            oper.getParamsMap().put("vOrgCode",2);
            oper.getParamsMap().put("vAccCode", r.getAttribute("AccCode"));
            oper.getParamsMap().put("vCurrCode", r.getAttribute("CurrCode"));
            oper.getParamsMap().put("vTrDate", dt);
            oper.getParamsMap().put("vTrDebit", r.getAttribute("Debit"));
            oper.getParamsMap().put("vTrCredit", r.getAttribute("Credit"));
            oper.execute();
//            System.out.println("----"+ADFUtils.getBoundAttributeValue("GlTrnsTypeId1"));
//            ADFUtils.setBoundAttributeValue("ReversedFlag1","N");
            ADFUtils.setBoundAttributeValue("PostFlag1","Y");
        }
//            System.out.println("----Post----");
        
        } catch (Exception e) {
    e.printStackTrace();
}
            ADFUtils.findOperation("Commit").execute();
           ADFUtils.findIterator("ReadOnlyGlDocumentsVIterator").executeQuery();
            return "toSave";         
        }

    public void createReverseDocument(ActionEvent actionEvent) {
        // Add event code here...
        Integer xx = null;
        ADFUtils.findOperation("Commit").execute();
        OperationBinding oper = ADFUtils.findOperation("reverse_document");
        
        oper.getParamsMap().put("vGlDocId",JSFUtil.resolveExpression("#{item.bindings.GlDocId.inputValue}"));   
//        oper.getParamsMap().put("vOrgCode",2);
        xx = (Integer) oper.execute();
//        System.out.println("----"+xx);
        JSFUtil.setExpressionValue("#{pageFlowScope.pGlDocId}", xx);

    }

    public void deleteGlDocument(ActionEvent actionEvent) {
        // Add event code here...
        if(!ADFUtils.getBoundAttributeValue("OriginGlDocId").toString().equals(null)) {
//            System.out.println("----"+ADFUtils.getBoundAttributeValue("OriginGlDocId"));
            ADFUtils.findOperation("update_original_gl_doc").execute();   
        }
        ADFUtils.findOperation("Delete").execute();
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findIterator("ReadOnlyGlDocumentsVIterator").executeQuery();
    }
}
