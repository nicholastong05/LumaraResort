package com.lumara.servlet.users;

import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/account/userbooking")
public class UserBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null)
                ? (Integer) session.getAttribute("userId")
                : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Map<String, Object>> bookings = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                "SELECT id, name, room_type, check_in, check_out, created_at " +
                "FROM bookings WHERE user_id = ? " +
                "ORDER BY created_at DESC";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    Map<String, Object> booking = new HashMap<>();
                    booking.put("id", rs.getInt("id"));
                    booking.put("name", rs.getString("name"));
                    booking.put("roomType", rs.getString("room_type"));
                    booking.put("checkIn", rs.getDate("check_in"));
                    booking.put("checkOut", rs.getDate("check_out"));
                    booking.put("createdAt", rs.getTimestamp("created_at"));
                    bookings.add(booking);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/account/userbooking.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null)
                ? (Integer) session.getAttribute("userId")
                : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String bookingId = request.getParameter("bookingId");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "DELETE FROM bookings WHERE id = ? AND user_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(bookingId));
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            session.setAttribute("bookingSuccess", "Booking cancelled.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("bookingError", "Failed to cancel booking.");
        }

        response.sendRedirect(request.getContextPath() + "/account/userbooking");
    }
}
