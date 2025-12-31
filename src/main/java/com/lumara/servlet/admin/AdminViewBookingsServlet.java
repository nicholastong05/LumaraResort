package com.lumara.servlet.admin;

import com.lumara.model.Booking;
import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/bookings")
public class AdminViewBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Booking> bookings = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM bookings ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setName(rs.getString("name"));
                b.setRoomType(rs.getString("room_type"));
                b.setCheckIn(rs.getDate("check_in"));
                b.setCheckOut(rs.getDate("check_out"));
                b.setCreatedAt(rs.getTimestamp("created_at"));

                bookings.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookingList", bookings);
        request.getRequestDispatcher("/admin/manage_bookings.jsp")
       .forward(request, response);

    }
}
