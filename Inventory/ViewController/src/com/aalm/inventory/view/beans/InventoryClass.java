package com.aalm.inventory.view.beans;

import com.shopbook.common.ui.ADFUtils;

import org.apache.myfaces.trinidad.event.ReturnEvent;

public class InventoryClass {
    public InventoryClass() {
    }

    public void refreshStoresRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
    ADFUtils.findIterator("StoresVIterator").executeQuery();
    }
}
