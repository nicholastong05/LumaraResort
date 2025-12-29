package com.lumara.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Initializing Database...");
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                // Create users table if not exists
                String createTableSQL = "CREATE TABLE IF NOT EXISTS users (" +
                        "id SERIAL PRIMARY KEY, " +
                        "username VARCHAR(50) UNIQUE NOT NULL, " +
                        "password VARCHAR(50) NOT NULL, " +
                        "role VARCHAR(20) NOT NULL)";

                try (Statement stmt = conn.createStatement()) {
                    stmt.execute(createTableSQL);
                    System.out.println("Users table checked/created.");
                }

                // Insert default users if not exist
                String insertUserSQL = "INSERT INTO users (username, password, role) " +
                        "VALUES (?, ?, ?) ON CONFLICT (username) DO NOTHING";

                try (PreparedStatement pstmt = conn.prepareStatement(insertUserSQL)) {
                    // Admin user
                    pstmt.setString(1, "admin");
                    pstmt.setString(2, "admin123");
                    pstmt.setString(3, "admin");
                    pstmt.addBatch();

                    // Standard user
                    pstmt.setString(1, "user");
                    pstmt.setString(2, "user123");
                    pstmt.setString(3, "user");
                    pstmt.addBatch();

                    pstmt.executeBatch();
                    System.out.println("Default users checked/inserted.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Database initialization failed: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
}
