package com.voter.portal;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Connection conn = DBConnection.getConnection();
            System.out.println("✅ DB connected successfully at Tomcat startup.");
            conn.close(); 
        } catch (Exception e) {
            System.err.println("❌ Failed to connect to DB at startup: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Optional: Clean up DB resources here if needed
    }
}
