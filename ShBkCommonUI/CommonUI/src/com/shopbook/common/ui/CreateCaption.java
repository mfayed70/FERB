package com.shopbook.common.ui;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;

public class CreateCaption {
    private String[] captions;
    public CreateCaption() {
    }

    public void initiateCaptions() {
        // Add event code here...
        ViewObject vo = ADFUtils.findIterator("ItemsListVIterator").getViewObject();
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
