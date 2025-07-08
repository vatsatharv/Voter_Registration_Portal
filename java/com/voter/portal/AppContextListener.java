package com.voter.portal;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("✅ JDBC Cleanup thread stopped.");
        } catch (Exception e) {
            System.err.println("❌ Error while shutting down JDBC Cleanup thread: " + e.getMessage());
        }
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // No action needed
    }
}
