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
                try (Statement stmt = conn.createStatement()) {
                    // Create rooms table if not exists
                    String createRoomsSQL = "CREATE TABLE IF NOT EXISTS rooms (" +
                            "id SERIAL PRIMARY KEY, " +
                            "room_type VARCHAR(100) UNIQUE NOT NULL, " +
                            "price DECIMAL(10,2) NOT NULL, " +
                            "capacity INT DEFAULT 100)";
                    stmt.execute(createRoomsSQL);
                    System.out.println("Rooms table checked/created.");

                    // Seed rooms data if table is empty
                    String seedRoomsSQL = "INSERT INTO rooms (room_type, price, capacity) " +
                            "VALUES (?, ?, ?) ON CONFLICT (room_type) DO NOTHING";
                    try (PreparedStatement prstmt = conn.prepareStatement(seedRoomsSQL)) {
                        String[][] rooms = {
                                { "Deluxe", "550.00", "100" },
                                { "Family Suite", "750.00", "100" },
                                { "Standard", "350.00", "100" }
                        };
                        for (String[] room : rooms) {
                            prstmt.setString(1, room[0]);
                            prstmt.setBigDecimal(2, new java.math.BigDecimal(room[1]));
                            prstmt.setInt(3, Integer.parseInt(room[2]));
                            prstmt.addBatch();
                        }
                        prstmt.executeBatch();
                        System.out.println("Initial rooms seeded.");
                    }

                    // Create users table if not exists
                    String createTableSQL = "CREATE TABLE IF NOT EXISTS users (" +
                            "id SERIAL PRIMARY KEY, " +
                            "username VARCHAR(50) UNIQUE NOT NULL, " +
                            "password VARCHAR(50) NOT NULL, " +
                            "role VARCHAR(20) NOT NULL)";
                    stmt.execute(createTableSQL);
                    System.out.println("Users table checked/created.");

                    // Create bookings table if not exists
                    String createBookingsSQL = "CREATE TABLE IF NOT EXISTS bookings (" +
                            "id SERIAL PRIMARY KEY, " +
                            "name VARCHAR(255) NOT NULL, " +
                            "room_type VARCHAR(100) NOT NULL, " +
                            "check_in DATE NOT NULL, " +
                            "check_out DATE NOT NULL, " +
                            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";
                    stmt.execute(createBookingsSQL);
                    System.out.println("Bookings table checked/created.");
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
