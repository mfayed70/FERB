package com.shopbook.common.adsEmail;
import java.sql.*;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import javax.sql.DataSource;

public class Helper {
    public Helper() {
        super();
    }
    private static Context ctx = null;
    private static DataSource ds = null;
    
    public static Connection getOracleConnection() throws Exception {
        Connection conn = null;
        try {
            if (ctx == null) {
                        ctx = new InitialContext();
                    }
        if (ds == null) {
                       ds = (DataSource)ctx.lookup("jdbc/AdsEmailTimer");  
                   }
        conn = ds.getConnection();
            
        }catch (SQLException sqle) {
            // TODO: Add catch code
            sqle.printStackTrace();
        } catch (NamingException ne) {
            // TODO: Add catch code
            ne.printStackTrace();
        } catch (Exception e) {
            // TODO: Add catch code
            e.printStackTrace();
        }
        return conn;
            
    }
}
