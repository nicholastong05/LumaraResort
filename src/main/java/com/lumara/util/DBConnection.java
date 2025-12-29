package com.lumara.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // TODO: Connect to NeonDB
    // Replace the strings below with your dashboard connection details
    private static final String URL = "jdbc:postgresql://ep-aged-dawn-a1oucbqp-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require";
    private static final String USER = "neondb_owner";
    private static final String PASSWORD = "npg_YTOHMpIxCi49";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("PostgreSQL Driver not found. Check dependencies.");
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
