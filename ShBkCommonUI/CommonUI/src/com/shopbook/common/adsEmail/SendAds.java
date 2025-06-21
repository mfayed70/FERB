package com.shopbook.common.adsEmail;
import javax.ejb.Schedule;
import javax.ejb.Singleton;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Singleton
public class SendAds {
    final String xMin="*/23";
    
//    @Schedule(hour="*/1", minute="*", second="*", persistent=false)  
    public void run(){
        System.out.println("start of timer 1 :"+new SimpleDateFormat ("yyyy-MM-dd  HH:mm:ss").format(new Date()));  
        Map<String, String> inlineImages = new HashMap<String, String>();
        HashMap<Integer,String[]> toAddress = new HashMap<Integer,String[]>();
        int i=0;int k = 0;
        Date dNow = new Date();
        SimpleDateFormat ft =  new SimpleDateFormat ("yyyy-MM-dd  HH:00:00");
        String _currDtTm = ft.format(dNow);
//        System.out.println("Current Date: " + ft.format(dNow));
        try {
            Connection conn = Helper.getOracleConnection();
            Statement stmt= conn.createStatement();              
            String _stmnt = "select * from offers,sys_parameters where ALREADY_SEND = 'false' and SEND_EMAIL_DT ='"+_currDtTm+"'";
            ResultSet rs=stmt.executeQuery(_stmnt);
            System.out.println("stmnt : "+_stmnt);
            while(rs.next()) {               
            System.out.println( rs.getTimestamp(4)+"  "+"----"+ rs.getLong(4)+"---"+ft.format(dNow)+"---");
              // get items images to be put in table
                try {
                    Statement stmnt_det = conn.createStatement();
                    ResultSet rs_det = stmnt_det.executeQuery("select * from offer_dets where OFFER_ID="+rs.getInt(1));
        //                    System.out.println("query : "+"select * from offer_dets where OFFER_ID="+rs.getInt(1));
                    while(rs_det.next())  {
                        i++;
        //                        System.out.println("image -"+rs_det.getString(1)+rs_det.getString(18));
                        inlineImages.put(rs_det.getString(1), rs_det.getString(18));
                    }
                    
                }catch (Exception e) {
            e.printStackTrace();
        } 
           // get list of users
            try {
                Statement stmnt_usrs = conn.createStatement();
                ResultSet _usr_rs = stmnt_usrs.executeQuery("select * from users");
                while(_usr_rs.next())  {
                    k++;
                    String[] user = {_usr_rs.getString(2),_usr_rs.getString(1)};
                    toAddress.put(k, user);
                    System.out.println("users :"+toAddress.get(k)[1]);
                }
                
            }catch (Exception e) {
                e.printStackTrace();
            }
                Statement stmnt_sysParams = conn.createStatement();
                ResultSet _sysParams_rs = stmnt_sysParams.executeQuery("select * from sys_parameters");
                PrepareToSend sendEmail = new PrepareToSend();
//                System.out.println("Add size : "+toAddress.size());
                while(_sysParams_rs.next()) {
                sendEmail.senEmail( _sysParams_rs.getString(6)//"mail.mymr.health"
                , _sysParams_rs.getString(7)// "465"
                , _sysParams_rs.getString(9)  //"registeration@mymr.health"
                , _sysParams_rs.getString(14)  //"bIY,i_]jRAAK"
                , toAddress ,rs.getString(3),
                rs.getString(11), rs.getString(30),inlineImages);
                }
             try {
                 Statement stmnt_end = conn.createStatement();
                stmnt_end.executeUpdate("update offers set ALREADY_SEND = 'true' where OFFER_MAST_ID="+rs.getInt(1));
                 stmnt_end.executeUpdate("commit");
             }catch (Exception e) {
             }
            conn.close();
        //                System.out.println("End of Timer :"+System.currentTimeMillis());
        }
        } catch (Exception e) {
        }
        System.out.println("End of Timer :"+new SimpleDateFormat ("yyyy-MM-dd  HH:mm:ss").format(new Date()));
    }
}
