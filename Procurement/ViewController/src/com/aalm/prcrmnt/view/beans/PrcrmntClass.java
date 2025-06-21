package com.aalm.prcrmnt.view.beans;

import com.shopbook.common.ui.ADFUtils;

import org.apache.myfaces.trinidad.event.ReturnEvent;

public class PrcrmntClass {
    public PrcrmntClass() {
    }

    public void refreshSuppliersRtrnLsnr(ReturnEvent returnEvent) {
        // Add event code here...
        ADFUtils.findIterator("SuppliersVIterator").executeQuery();
    }
}
