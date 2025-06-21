package com.aalm.center.view.beans;

import com.shopbook.common.ui.ADFUtils;

import com.shopbook.common.ui.JSFUtil;

import java.util.Iterator;

import java.util.List;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.faces.event.ValueChangeEvent;

//import oracle.adf.mbean.share.config.adfc.String;
import oracle.adf.model.binding.DCIteratorBinding;
import oracle.adf.view.rich.component.rich.RichPopup;
import oracle.adf.view.rich.component.rich.data.RichTable;
import oracle.adf.view.rich.component.rich.data.RichTreeTable;
import oracle.adf.view.rich.component.rich.input.RichInputText;
import oracle.adf.view.rich.component.rich.input.RichSelectBooleanCheckbox;

import oracle.adf.view.rich.component.rich.nav.RichButton;

import oracle.adf.view.rich.context.AdfFacesContext;

import oracle.adf.view.rich.model.FilterableQueryDescriptor;

import oracle.binding.OperationBinding;

import oracle.jbo.Key;
import oracle.jbo.Row;

import oracle.jbo.RowSet;

import oracle.jbo.RowSetIterator;
import oracle.jbo.ViewObject;

import oracle.jbo.uicli.binding.JUCtrlHierNodeBinding;

import org.apache.myfaces.trinidad.context.RequestContext;
import org.apache.myfaces.trinidad.event.ReturnEvent;
import org.apache.myfaces.trinidad.model.RowKeySet;

public class CentralBean {
    public String refresh_region;
    private RichSelectBooleanCheckbox isAssmblyChckBox;
    private RichButton addComponentBtn;
    private RichTreeTable merialAssTree;
    private RichPopup chooseUnitCatPopup;
    private boolean checkAll;
    private RichTable itemTestTbl;
    private RichTable itemListTbl;
    private String[] captions;
    private RichInputText vvarValCode;
    private RichInputText vvarValValue;

    public void setRefresh_region(String refresh_region) {
        this.refresh_region = refresh_region;
    }

    public String getRefresh_region() {
        return String.valueOf(System.currentTimeMillis());
    }

    public void saveItemListActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        Key myKey = ADFUtils.findIterator("ItemsListVIterator").getCurrentRow().getKey();
            ADFUtils.findOperation("Commit").execute();  
     ADFUtils.findIterator("ItemsListVIterator").executeQuery();
    ADFUtils.findIterator("ItemsListVIterator").setCurrentRowWithKey(myKey.toStringFormat(true));
        System.out.println("is assembly :" + JSFUtil.resolveExpressionAsBoolean("#{row.bindings.IsAssmbly.inputValue}"));
        ADFUtils.findOperation("Commit").execute();
        System.out.println("iter 2 :"+ADFUtils.findIterator("ItemsStructureV2Iterator").getEstimatedRowCount());
        if(ADFUtils.findIterator("ItemsStructureV2Iterator").getEstimatedRowCount()==0 
        && ADFUtils.findIterator("ItemsStructureV1Iterator").getEstimatedRowCount()==1) {
            ADFUtils.findOperation("DeleteMastAss").execute();
            ADFUtils.findOperation("Commit").execute();
            ADFUtils.setBoundAttributeValue("IsAssmbly", false);
            ADFUtils.findOperation("Commit").execute();
        }
//    }  
 }

    public void setIsAssmblyChckBox(RichSelectBooleanCheckbox isAssmblyChckBox) {
        this.isAssmblyChckBox = isAssmblyChckBox;
    }

    public RichSelectBooleanCheckbox getIsAssmblyChckBox() {
        return isAssmblyChckBox;
    }


    public String saveComponentsToAss() {
        // Add event code here...
        ViewObject vo = ADFUtils.findIterator("ItemsToBeSelectedInAssIterator").getViewObject();
//        vo.executeQuery();
        Row[] seldRows = vo.getFilteredRows("Selected", "Y");
        System.out.println("b4 for loop :"+seldRows.length+" total recs : "+vo.getEstimatedRowCount());
        for (Row r : seldRows) {
            System.out.println("row val :"+r.getAttribute("Selected")+"--"+
            JSFUtil.resolveExpressionAsString("#{pageFlowScope.pAssCode}")+"++++"+JSFUtil.resolveExpressionAsString("#{pageFlowScope.pItemCode}")
                               +"---item code : "+r.getAttribute("ItemCode"));
            OperationBinding oper = ADFUtils.findOperation("CreateWithParams");
            oper.getParamsMap().put("ItemCode", r.getAttribute("ItemCode"));
            oper.getParamsMap().put("QtyInAss",1);
            oper.getParamsMap().put("UnitId", r.getAttribute("UnitId"));
            oper.execute();
            ADFUtils.findOperation("Commit").execute();
            System.out.println("");
        }
 
        return "toSave";
    }

//    public void addComponentRtrnLsnr(ReturnEvent returnEvent) {
//        // Add event code here...
////        ADFUtils.findIterator("ItemsListVIterator").executeQuery();
////        ADFUtils.findIterator("ItemsStructureV1Iterator").executeQuery();     
//    }
//
    public String addComponentActn() {
        // Add event code here...
        System.out.println("is assembly : "+JSFUtil.resolveExpressionAsBoolean("#{row.bindings.IsAssmbly.inputValue}")+
                " -from binding : "+ADFUtils.getBoundAttributeValue("IsAssmbly"));
        if (!JSFUtil.resolveExpressionAsBoolean("#{row.bindings.IsAssmbly.inputValue}")) {
        ADFUtils.findOperation("CreateWithParamsMastAss").execute();
            JSFUtil.setExpressionValue("#{row.bindings.IsAssmbly.inputValue}", true);
        }
        return "selectAssComponents";
    }


    public void setAddComponentBtn(RichButton addComponentBtn) {
        this.addComponentBtn = addComponentBtn;
    }

    public RichButton getAddComponentBtn() {
        return addComponentBtn;
    }

    public void delAssComponent(ActionEvent actionEvent) {
        // Add event code here...
        String mstItem = (String) ADFUtils.getBoundAttributeValue("ItemCode");
        String assCode = (String) actionEvent.getComponent().getAttributes().get("assCode");
        String itmCode = (String) actionEvent.getComponent().getAttributes().get("itemCode");
        System.out.println(mstItem+"--"+assCode+"--"+itmCode);
        if(assCode.equals(mstItem)) {
        RichTreeTable treeTable = this.getMerialAssTree();
        RowKeySet rks = treeTable.getSelectedRowKeys();
        Iterator keys = rks.iterator();
        while(keys.hasNext())   {
            List key = (List) keys.next();
            treeTable.setRowKey(key);
            JUCtrlHierNodeBinding node = (JUCtrlHierNodeBinding) treeTable.getRowData();
            Row rw = node.getRow();
            System.out.println("Selected: "+rw.getAttribute("AssCode")+"---"+rw.getAttribute("ItemCode"));
            rw.remove();
            AdfFacesContext.getCurrentInstance().addPartialTarget(treeTable);
        }
     }
//        else if(assCode==null) {
//            ViewObject voDet = ADFUtils.findIterator("ItemsStructureV2Iterator").getViewObject();
//            ADFUtils.findIterator("arg0").getViewObject().executeQuery();
//            Row[] rw = voDet.getAllRowsInRange();
//            System.out.println("rows :"+rw.length);
//            for (Row r :rw) {
//                System.out.println("row item code :"+r.getAttribute("ItemCode"));
//                r.remove();
//            }
//            
//        }
        System.out.println("rows :"+ADFUtils.findIterator("ItemsStructureV1Iterator").getEstimatedRowCount()+
                           "--"+ADFUtils.findIterator("ItemsStructureV2Iterator").getEstimatedRowCount());
    }

    public void setMerialAssTree(RichTreeTable merialAssTree) {
        this.merialAssTree = merialAssTree;
    }

    public RichTreeTable getMerialAssTree() {
        return merialAssTree;
    }

    public void newItemActnLsnr(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.findOperation("CreateInsert").execute(); 
    }

//    public void addToItemStructure(ActionEvent actionEvent) {
//        // Add event code here...
////        ADFUtils.findOperation("Commit").execute();
//        System.out.println("----"+ JSFUtil.resolveExpressionAsString("#{row.bindings.VarCode.inputValue}")+
//                           "----"+JSFUtil.resolveExpressionAsString("#{row.bindings.VarName.inputValue}"));
//        OperationBinding add_item = ADFUtils.findOperation("add_item_structure");
//
//        add_item.getParamsMap().put("origCol", JSFUtil.resolveExpressionAsString("#{row.bindings.VarCode.inputValue}"));
//        add_item.getParamsMap().put("COLNAME", JSFUtil.resolveExpressionAsString("#{row.bindings.VarName.inputValue}"));
//        add_item.execute();
//        JSFUtil.setExpressionValue("#{bindings.CartizianApplied.inputValue}", true);
//        ADFUtils.findOperation("Commit").execute();
//    }
    public void createItemsTest(ActionEvent actionEvent) {
        // Add event code here... 
        ViewObject vo = ADFUtils.findIterator("ItemVariablesVIterator").getViewObject();
           Row[] rws = vo.getFilteredRows("Ordr",1);
          System.out.println("exist : "+rws.length);//+" ---- "+rws[0].getAttribute("VarCode").toString());
           if (rws.length>0) {
               OperationBinding oper = ADFUtils.findOperation("setCurrentRowWithKeyValue");
               oper.getParamsMap().put("rowKey", rws[0].getAttribute("VarCode").toString());
               oper.execute();
               ViewObject vo1 = ADFUtils.findIterator("ItemVariableValuesVIterator").getViewObject();
               Row[] rws1 = vo1.getFilteredRows("CartizianApplied","Y");
               System.out.println("view rows  : "+vo1.getEstimatedRowCount()+" ---- rws cnt : "+rws1.length);
                  System.out.println("exist 1 : "+rws1.length);
               if(rws1.length>0) {
        RichPopup.PopupHints hints = new RichPopup.PopupHints();
        this.getChooseUnitCatPopup().show(hints);
               } else JSFUtil.addFacesErrorMessage("choose at least 1 value in order 1,---إختار علي الأقل قيمة1 في الترتيب 1");
           } else JSFUtil.addFacesErrorMessage("specify order, at least 1---حدد الترتيب علي الأقل 1");
    }


    public void okPopupBut(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.findOperation("Commit").execute();
            ADFUtils.findOperation("create_items_from_variables").execute();
            System.out.println("done");
        RichPopup.PopupHints hints = new RichPopup.PopupHints();
        this.getChooseUnitCatPopup().hide();
        ADFUtils.findIterator("ItemVariablesTestVIterator").executeQuery();
        ADFUtils.findOperation("Rollback").execute();
    }
    
    public void cancelPopupBut(ActionEvent actionEvent) {
        // Add event code here...
        RichPopup.PopupHints hints = new RichPopup.PopupHints();
        this.getChooseUnitCatPopup().hide();
    }
 
    public void addItemsToListItems(ActionEvent actionEvent) {
        // Add event code here...   
        ADFUtils.findOperation("create_items_from_item_variables_test").execute();
        ADFUtils.findIterator("ItemVariablesTestVIterator").executeQuery();
    }
    
    public void setChooseUnitCatPopup(RichPopup chooseUnitCatPopup) {
        this.chooseUnitCatPopup = chooseUnitCatPopup;
    }

    public RichPopup getChooseUnitCatPopup() {
        return chooseUnitCatPopup;
    }


    public void uncheckSelected(ActionEvent actionEvent) {
        // Add event code here...
        ViewObject vo = ADFUtils.findIterator("ItemVariableValuesVIterator").getViewObject();
        Row[] rws = vo.getFilteredRows("CartizianApplied", "Y");
        for (Row r : rws) {
            r.setAttribute("CartizianApplied", "");
                        }
        ADFUtils.findOperation("Commit").execute();
    }

    public void deleteAllTestItems(ActionEvent actionEvent) {
        // Add event code here...
        ADFUtils.findOperation("delete_items_from_item_variables_test").execute();
        ADFUtils.findIterator("ItemVariablesTestVIterator").executeQuery();
}

    public void checkUncheckAllItemVarValues(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
        valueChangeEvent.getComponent().processUpdates(FacesContext.getCurrentInstance());
            if (valueChangeEvent.getNewValue().equals(true)) {
            System.out.println("----"+valueChangeEvent.getNewValue().toString());
            ViewObject vo = ADFUtils.findIterator("ItemVariableValuesVIterator").getViewObject();
            RowSetIterator rs = vo.createRowSetIterator("new");
            if(rs != null) {
                rs.reset();
                while(rs.hasNext()){
//                    System.out.println("---- "+vo.getEstimatedRowCount());
                    Row currRow = rs.next();
                    currRow.setAttribute("CartizianApplied", "Y");
                }
            }  
            ADFUtils.findOperation("Commit").execute();
            rs.closeRowSetIterator();
            ADFUtils.findIterator("ItemVariablesVaaluesStatisticsIterator").clearForRecreate();
            ADFUtils.findIterator("ItemVariablesVaaluesStatisticsIterator").executeQuery();
        
        } else {
                System.out.println("++++"+valueChangeEvent.getNewValue().toString());
            ViewObject vo = ADFUtils.findIterator("ItemVariableValuesVIterator").getViewObject();
            RowSetIterator rs1 = vo.createRowSetIterator("old");
            if(rs1 != null) {
                rs1.reset();
                while(rs1.hasNext()){
//                    System.out.println("+++++ "+vo.getEstimatedRowCount());
                    Row currRow = rs1.next();
                    currRow.setAttribute("CartizianApplied","N");
                }
            }  
            ADFUtils.findOperation("Commit").execute();
                rs1.closeRowSetIterator();
            ADFUtils.findIterator("ItemVariablesVaaluesStatisticsIterator").clearForRecreate();
            ADFUtils.findIterator("ItemVariablesVaaluesStatisticsIterator").executeQuery();
            
        }
    }

    public String saveForm() {
        // Add event code here...
//        ADFUtils.findIterator("ItemVariableValuesVIterator").clearForRecreate();
//        ADFUtils.findIterator("ItemVariableValuesVIterator").executeQuery();
//        ADFUtils.findIterator("ItemVariablesVaaluesStatisticsIterator").clearForRecreate();
        ADFUtils.findIterator("ItemVariablesVaaluesStatisticsIterator").executeQuery();
        
        return null;
    }

    public void setCheckAll(boolean checkAll) {
        this.checkAll = checkAll;
    }

    public boolean isCheckAll() {
        return checkAll;
    }

    public void checkItemValue(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
        valueChangeEvent.getComponent().processUpdates(FacesContext.getCurrentInstance());
        ADFUtils.findOperation("Commit").execute();
        ADFUtils.findIterator("ItemVariablesVaaluesStatisticsIterator").executeQuery();

    }

    public String clearItemTestFilter() {
        // Add event code here...
        RichTable table = this.getItemTestTbl();
        FilterableQueryDescriptor filterDescriptor = (FilterableQueryDescriptor)table.getFilterModel();
        filterDescriptor.getFilterCriteria().clear();
        ADFUtils.findIterator("ItemVariablesTestVIterator").executeQuery();
        return null;
    }

    public void setItemTestTbl(RichTable itemTestTbl) {
        this.itemTestTbl = itemTestTbl;
    }

    public RichTable getItemTestTbl() {
        return itemTestTbl;
    }

    public String clearItemListFilter() {
        // Add event code here...
        RichTable table = this.getItemListTbl();
        FilterableQueryDescriptor filterDescriptor = (FilterableQueryDescriptor)table.getFilterModel();
        filterDescriptor.getFilterCriteria().clear();
        ADFUtils.findIterator("ItemsListVIterator").executeQuery();
        return null;
    }


    public void setItemListTbl(RichTable itemListTbl) {
        this.itemListTbl = itemListTbl;
    }

    public RichTable getItemListTbl() {
        return itemListTbl;
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

    public void delSelectedItems(ActionEvent actionEvent) {
        // Add event code here...
        ViewObject vo = ADFUtils.findIterator("ItemVariablesTestVIterator").getViewObject();
        Row[] r = vo.getFilteredRows("Selected", true);
//        System.out.println("rows : "+vo.getEstimatedRowCount());
        for (Row rws : r) {
         rws.remove();
                        }
    }

    public void varVlaueChngLsnr(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
//        System.out.println("new val "+valueChangeEvent.getNewValue()+"  ---- old val "+valueChangeEvent.getOldValue());
        OperationBinding oper1 = ADFUtils.findOperation("validate_var_value");
        String voldVal = valueChangeEvent.getOldValue().toString();
        String yyy = "%".concat(valueChangeEvent.getOldValue().toString()).concat("%");
        oper1.getParamsMap().put("v_val", yyy);
        oper1.execute();
        if (Integer.parseInt(oper1.getResult().toString())>0) {
        JSFUtil.addFacesErrorMessage("This item exist in Items List, you can't change it");
        this.vvarValCode.setValue(valueChangeEvent.getOldValue());
            }
    }

    public void varValValueChngLsnr(ValueChangeEvent valueChangeEvent) {
        // Add event code here...
//        System.out.println("+++"+this.vvarValCode.getValue());
        OperationBinding chngOper = ADFUtils.findOperation("validate_var_value");
        chngOper.getParamsMap().put("v_val", "%".concat(this.vvarValCode.getValue().toString().concat("%")));
        chngOper.execute();
        if(Integer.parseInt(chngOper.getResult().toString())>0) {
            JSFUtil.addFacesErrorMessage("This item exist in Items List, you can't change it");
            this.vvarValValue.setValue(valueChangeEvent.getOldValue());
        }
    }
    
    public void varValueValidator(FacesContext facesContext, UIComponent uIComponent, Object object) {
        // Add event code here...
        

    }

    public void setVvarValCode(RichInputText vvarValCode) {
        this.vvarValCode = vvarValCode;
    }

    public RichInputText getVvarValCode() {
        return vvarValCode;
    }

    public void setVvarValValue(RichInputText vvarValValue) {
        this.vvarValValue = vvarValValue;
    }

    public RichInputText getVvarValValue() {
        return vvarValValue;
    }
}
