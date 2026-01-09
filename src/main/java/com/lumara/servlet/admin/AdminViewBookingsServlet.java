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
import java.util.Map;
import java.util.HashMap;


@WebServlet("/admin/bookings")
public class AdminViewBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Booking> bookings = new ArrayList<>();
        List<String> roomTypes = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            //  BOOKINGS
            String bookingSql = "SELECT * FROM bookings ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(bookingSql);
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

            // 2ROOM TYPES
            String roomSql = "SELECT room_type FROM rooms ORDER BY room_type ASC";
            PreparedStatement psRoom = conn.prepareStatement(roomSql);
            ResultSet rsRoom = psRoom.executeQuery();

            while (rsRoom.next()) {
                roomTypes.add(rsRoom.getString("room_type"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // THESE TWO LINES MUST EXIST
        request.setAttribute("bookingList", bookings);
        request.setAttribute("roomTypes", roomTypes);

        request.getRequestDispatcher("/admin/manage_bookings.jsp")
               .forward(request, response);
    }
}

