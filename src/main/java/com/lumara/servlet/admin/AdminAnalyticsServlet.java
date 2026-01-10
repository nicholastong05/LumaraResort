package com.lumara.servlet.admin;

import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/admin/analytics")
public class AdminAnalyticsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Admin guard
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int totalUsers = 0;
        int totalBookings = 0;
        double totalRevenue = 0.0;

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // USERS
            ResultSet rsUsers =
                    stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rsUsers.next()) {
                totalUsers = rsUsers.getInt(1);
            }

            // BOOKINGS
            ResultSet rsBookings =
                    stmt.executeQuery("SELECT COUNT(*) FROM bookings");
            if (rsBookings.next()) {
                totalBookings = rsBookings.getInt(1);
            }

            // REVENUE
            ResultSet rsRevenue = stmt.executeQuery(
                "SELECT SUM(r.price) " +
                "FROM bookings b " +
                "JOIN rooms r ON b.room_type = r.room_type"
            );
            if (rsRevenue.next()) {
                totalRevenue = rsRevenue.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", totalRevenue);

        request.getRequestDispatcher("/admin/admin_analytics.jsp")
               .forward(request, response);
    }
}
