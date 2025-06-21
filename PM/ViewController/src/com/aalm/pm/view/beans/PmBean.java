package com.aalm.pm.view.beans;

import com.shopbook.common.ui.ADFUtils;
import com.shopbook.common.ui.JSFUtil;

import java.math.BigDecimal;

import java.util.Iterator;

import java.util.List;

import javax.faces.event.ActionEvent;

import javax.faces.event.ValueChangeEvent;

import javax.swing.tree.TreeModel;

import oracle.adf.view.rich.component.rich.data.RichTreeTable;

import oracle.adf.view.rich.component.rich.input.RichInputText;
import oracle.adf.view.rich.component.rich.nav.RichButton;
import oracle.adf.view.rich.context.AdfFacesContext;

import oracle.binding.OperationBinding;

import oracle.jbo.Key;
import oracle.jbo.Row;

import oracle.jbo.RowIterator;
import oracle.jbo.RowSet;

import oracle.jbo.ViewObject;
import oracle.jbo.server.ViewObjectImpl;
import oracle.jbo.uicli.binding.JUCtrlHierBinding;

import oracle.jbo.uicli.binding.JUCtrlHierNodeBinding;

import org.apache.myfaces.trinidad.event.DisclosureEvent;
import org.apache.myfaces.trinidad.event.ReturnEvent;
import org.apache.myfaces.trinidad.event.SelectionEvent;
import org.apache.myfaces.trinidad.model.CollectionModel;
import org.apache.myfaces.trinidad.model.RowKeySet;

public class PmBean {
    private RichTreeTable projSectionTree;
    private RowIterator iterProjSection;
    private RowIterator iterSectionItem;
    private Key keyProjsection;
    private Key keySectionItem;
    private String treeCurrKey;
    private String itemsTreeCurrKey;
    private RichTreeTable sectionItemTree;
    private RichInputText qty;
    private RichInputText unitCost;
    private RichInputText suppDisc;
    private RichInputText customs;
    private RichInputText salesTax;
    private int sectionTreeChildCount;
    private RichInputText totCost;
    private RichInputText trnsTotCost;

    public PmBean() {
    }

    public void projSectionsTreeSelListener(SelectionEvent selectionEvent) {
        // Add event code here...
        JSFUtil.invokeMethodExpression("#{bindings.ProjectSectionItemsV.treeModel.makeCurrent}",Object.class, SelectionEvent.class, selectionEvent);
        RichTreeTable treeTable = this.getProjSectionTree();
        RowKeySet rks = treeTable.getSelectedRowKeys();
        Iterator rksIter = rks.iterator();

            List key = (List) rksIter.next();
        JUCtrlHierBinding treeTableBinding = null;

        treeTableBinding = (JUCtrlHierBinding)((CollectionModel)treeTable.getValue()).getWrappedData();
        JUCtrlHierNodeBinding nodeBinding = (JUCtrlHierNodeBinding) treeTableBinding.findNodeByKeyPath(key);
         treeTable.setRowKey(key);
         
//         OperationBinding oper = ADFUtils.findOperation("ExecuteWithParams");
//            oper.getParamsMap().put("pSectionId", nodeBinding.getRow().getAttribute("SectionId"));
//            System.out.println("section node binding : "+nodeBinding.getRow().getAttribute("SectionId"));
//         oper.execute();
//         this.setTreeCurrKey(nodeBinding.getRow().getAttribute("SectionId").toString()); 
         
            if(nodeBinding.getRow().getAttribute("SectionId").toString().isEmpty()) 
//            if(Integer.parseInt(ADFUtils.getBoundAttributeValue("ItemsCount").toString())==0)
            {
                System.out.println(" No detailed Items");
                JSFUtil.setExpressionValue("#{sessionScope.showItemsTree}", true);
                return;
            }   else {
                OperationBinding oper = ADFUtils.findOperation("ExecuteWithParams");
                   oper.getParamsMap().put("pSectionId", nodeBinding.getRow().getAttribute("SectionId"));
                   System.out.println("node binding : "+nodeBinding.getRow().getAttribute("SectionId"));
                oper.execute();
                System.out.println("from if");
                this.setTreeCurrKey(nodeBinding.getRow().getAttribute("SectionId").toString());
            }
            int xx = Integer.parseInt(nodeBinding.getRow().getAttribute("ChildCount").toString());
            this.setSectionTreeChildCount(xx);
System.out.println("childCount: "+nodeBinding.getRow().getAttribute("ChildCount"));
        JSFUtil.setExpressionValue("#{sessionScope.showItemsTree}", true);
     }


    public void createMainSection(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.findOperation("CreateMainSection").execute();
    }

    public void createSubSection(ActionEvent actionEvent) {
        // Add event code here...
//        ADFUtils.findOperation("CreateSubSection").execute();
//        this.setSectionTreeChildCount(1);
//      AdfFacesContext.getCurrentInstance().addPartialTarget(this.projSectionTree);
//-----------------------------------
      RichTreeTable treeTable = this.getProjSectionTree();  
        for (Object keyObj : treeTable.getSelectedRowKeys()){
            RowIterator rowIter;
            Key selectedNodeRowKey;
            treeTable.setRowKey(keyObj);
            rowIter = ((JUCtrlHierNodeBinding)treeTable.getRowData()).getRowIterator();
            selectedNodeRowKey = ((JUCtrlHierNodeBinding)treeTable.getRowData()).getRowKey();
            if (rowIter !=null && selectedNodeRowKey != null){
                Row last = rowIter.last();
                System.out.println("section key : "+last.getAttribute("SectionId"));
                last.setAttribute("Qty", 1);
//                last.setAttribute("TotalCost", 1);
//                last.setAttribute("MasterUnitCost", 1);
//                last.setAttribute("TotCostAftrOvrhead", 1);
               Key lastRowKey = last.getKey();
                Row[] found = rowIter.findByKey(selectedNodeRowKey, 1);
                if (found != null && found.length == 1) {
                    Row foundRow = found[0];
                    String nodeDefname = foundRow.getStructureDef().getDefFullName();
                System.out.println(" node def. : "+nodeDefname);
              RowSet parents = (RowSet)foundRow.getAttribute("ProjectSectionsV");
                    Row childrow = parents.createRow();
                    childrow.setAttribute("ProjId", foundRow.getAttribute("ProjId"));
                    childrow.setAttribute("VersionNo", foundRow.getAttribute("VersionNo"));
                    parents.insertRow(childrow);
                }
            }
        } 
    }

    public void sectionItemSelListnerTree(SelectionEvent selectionEvent) {
        // Add event code here...
        JSFUtil.invokeMethodExpression("#{bindings.ProjectSectionItemsV.treeModel.makeCurrent}",Object.class, SelectionEvent.class, selectionEvent);
        RichTreeTable treeTable = this.getSectionItemTree();
        RowKeySet rks = treeTable.getSelectedRowKeys();
        Iterator rksIter = rks.iterator();
        while(rksIter.hasNext()) {
            List key = (List) rksIter.next();
        System.out.println("items key is : "+key.toString());
        this.setItemsTreeCurrKey(key.toString());
        System.out.println("after set : "+this.getItemsTreeCurrKey());
        treeTable.setRowKey(key);
            JUCtrlHierNodeBinding node = (JUCtrlHierNodeBinding) treeTable.getRowData();
            Row rw = node.getRow();
        }
        AdfFacesContext.getCurrentInstance().addPartialTarget(treeTable);
//------------------------------------------
//        JUCtrlHierBinding treeTableBinding = null;
//        treeTableBinding = (JUCtrlHierBinding)((CollectionModel)treeTable.getValue()).getWrappedData();
//        JUCtrlHierNodeBinding nodeBinding = (JUCtrlHierNodeBinding) treeTableBinding.findNodeByKeyPath(key);
//         treeTable.setRowKey(key);
    }

    public void createGroupPrice(ActionEvent actionEvent) {
        // Add event code here...
        System.out.println("from create : "+ this.getTreeCurrKey()+"---binding : "+
            JSFUtil.resolveExpressionAsString("${pageFlowScope.PmBean.treeCurrKey}"));
        OperationBinding oper = ADFUtils.findOperation("CreateGroupPricing");
        oper.getParamsMap().put("SectionId", this.getTreeCurrKey());
        oper.execute();
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findOperation("Rollback").execute();
    }

    public void createItemPricing(ActionEvent actionEvent) {
        // Add event code here...
        System.out.println("from create : "+this.getTreeCurrKey());
       
        JSFUtil.resolveExpressionAsString("${pageFlowScope.PmBean.treeCurrKey}");
        OperationBinding oper = ADFUtils.findOperation("CreateItemPricing");
        oper.getParamsMap().put("SectionId", this.getTreeCurrKey());
        oper.execute();
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findOperation("Rollback").execute();
    }


    public void createSectionItemChild(ActionEvent actionEvent) {
//        Add event code here...
//        AdfFacesContext.getCurrentInstance().addPartialTarget(this.sectionItemTree);
        RichTreeTable treeTable = this.getSectionItemTree();
        for (Object keyObj : treeTable.getSelectedRowKeys()){
            RowIterator rowIter;
            Key selectedNodeRowKey;
            treeTable.setRowKey(keyObj);
            rowIter = ((JUCtrlHierNodeBinding)treeTable.getRowData()).getRowIterator();
            selectedNodeRowKey = ((JUCtrlHierNodeBinding)treeTable.getRowData()).getRowKey();
            if (rowIter !=null && selectedNodeRowKey != null){
                Row last = rowIter.last();
                System.out.println("section item key : "+last.getAttribute("SectionItemId"));
                last.setAttribute("Qty", 1);
                last.setAttribute("UnitCost", 0);
                last.setAttribute("SuppDiscountPerc", 0);
                last.setAttribute("CustomsPerc", 0);
                last.setAttribute("SalesTaxPerc", 0);
                last.setAttribute("UnitId", null);
                last.setAttribute("CurrCode", null);
               Key lastRowKey = last.getKey();
                Row[] found = rowIter.findByKey(selectedNodeRowKey, 1);
                if (found != null && found.length == 1) {
                    Row foundRow = found[0];
                    String nodeDefname = foundRow.getStructureDef().getDefFullName();
                System.out.println(" node def. : "+nodeDefname);
              RowSet parents = (RowSet)foundRow.getAttribute("ProjectSectionItemsV");
                    Row childrow = parents.createRow();
                    childrow.setAttribute("SectionId", foundRow.getAttribute("SectionId"));
                    parents.insertRow(childrow);
                }
            }
        }
    }

    public void projPricingCommit(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.findOperation("Commit").execute();
        if(Integer.parseInt(ADFUtils.getBoundAttributeValue("ChildCount").toString())>0) {
//            ADFUtils.findOperation("Rollback").execute();            
            return;
        }
        JSFUtil.setExpressionValue("#{sessionScope.showSections}", true);
    }

    public void deleteProjSection(ActionEvent actionEvent) {
        // Add event code here...
        RichTreeTable treeTable = this.getProjSectionTree();
        RowKeySet rks = treeTable.getSelectedRowKeys();
        Iterator keys = rks.iterator();
        while(keys.hasNext()){
            List key = (List) keys.next();
            treeTable.setRowKey(key);
            JUCtrlHierNodeBinding node = (JUCtrlHierNodeBinding) treeTable.getRowData();
            Row rw = node.getRow();
            rw.remove();
            AdfFacesContext.getCurrentInstance().addPartialTarget(treeTable);
        }
    }

    public void deleteSectionItem(ActionEvent actionEvent) {
        // Add event code here...
        RichTreeTable treeTable1 = this.getSectionItemTree();
        RowKeySet rks = treeTable1.getSelectedRowKeys();
        Iterator keys1 = rks.iterator();
        System.out.println("b4 loop");
        while(keys1.hasNext()){
            List key1 = (List) keys1.next();
            treeTable1.setRowKey(key1);
            JUCtrlHierNodeBinding node1 = (JUCtrlHierNodeBinding) treeTable1.getRowData();
            Row rw1 = node1.getRow();
            rw1.remove();
            System.out.println("in the loop");
        }
        AdfFacesContext.getCurrentInstance().addPartialTarget(treeTable1);
    }

    public void selectItemRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        if (JSFUtil.resolveExpressionAsBoolean("#{pageFlowScope.returnSelected}")) {
        System.out.println("rtrn Lsnr: "+JSFUtil.resolveExpressionAsString("#{pageFlowScope.returnItemCode}"));
        JSFUtil.setExpressionValue("#{node.bindings.ItemCode.inputValue}", JSFUtil.resolveExpressionAsString("#{pageFlowScope.returnItemCode}"));
        JSFUtil.setExpressionValue("#{node.bindings.ItemIndx.inputValue}", JSFUtil.resolveExpressionAsString("#{pageFlowScope.returnItemIndx}"));
        JSFUtil.setExpressionValue("#{node.bindings.ItemName.inputValue}", JSFUtil.resolveExpressionAsString("#{pageFlowScope.returnItemName}"));
             System.out.println("item code: "+JSFUtil.resolveExpressionAsString("#{node.ItemCode}"));
         } else return;
    }
    
    public void setProjSectionTree(RichTreeTable projSectionTree) {
        this.projSectionTree = projSectionTree;
    }

    public RichTreeTable getProjSectionTree() {
        return projSectionTree;
    }


    public void setTreeCurrKey(String treeCurrKey) {
        this.treeCurrKey = treeCurrKey;
    }

    public String getTreeCurrKey() {
        return treeCurrKey;
    }

    public void setSectionItemTree(RichTreeTable sectionItemTree) {
        this.sectionItemTree = sectionItemTree;
    }

    public RichTreeTable getSectionItemTree() {
        return sectionItemTree;
    }

    public void setItemsTreeCurrKey(String itemsTreeCurrKey) {
        this.itemsTreeCurrKey = itemsTreeCurrKey;
    }

    public String getItemsTreeCurrKey() {
        return itemsTreeCurrKey;
    }

    public void valChngListener(ValueChangeEvent valueChangeEvent) {
        // Add event code here..
//         System.out.println("val : new "+valueChangeEvent.getNewValue()+"---- "+valueChangeEvent.getOldValue());
        if(valueChangeEvent.getNewValue()==null){
          
            if (valueChangeEvent.getComponent().getId().toString().equals("it8"))this.qty.setValue(0);
            
           else if (valueChangeEvent.getComponent().getId().toString().equals("it10"))this.unitCost.setValue(0);
            
           else if (valueChangeEvent.getComponent().getId().toString().equals("it11"))this.suppDisc.setValue(0);
            
           else if (valueChangeEvent.getComponent().getId().toString().equals("it12"))this.customs.setValue(0);
            
           else if (valueChangeEvent.getComponent().getId().toString().equals("it13"))this.salesTax.setValue(0);
        }

    }

    public void setQty(RichInputText qty) {
        this.qty = qty;
    }

    public RichInputText getQty() {
        return qty;
    }

    public void setUnitCost(RichInputText unitCost) {
        this.unitCost = unitCost;
    }

    public RichInputText getUnitCost() {
        return unitCost;
    }

    public void setSuppDisc(RichInputText suppDisc) {
        this.suppDisc = suppDisc;
    }

    public RichInputText getSuppDisc() {
        return suppDisc;
    }

    public void setCustoms(RichInputText customs) {
        this.customs = customs;
    }

    public RichInputText getCustoms() {
        return customs;
    }

    public void setSalesTax(RichInputText salesTax) {
        this.salesTax = salesTax;
    }

    public RichInputText getSalesTax() {
        return salesTax;
    }


    public void setSectionTreeChildCount(int sectionTreeChildCount) {
        this.sectionTreeChildCount = sectionTreeChildCount;
    }

    public int getSectionTreeChildCount() {
        return sectionTreeChildCount;
    }

    public void cancelActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.findOperation("Rollback").execute();
    }

    public void setTrnsTotCost(RichInputText trnsTotCost) {
        this.trnsTotCost = trnsTotCost;
    }

    public RichInputText getTrnsTotCost() {
        return trnsTotCost;
    }

}

