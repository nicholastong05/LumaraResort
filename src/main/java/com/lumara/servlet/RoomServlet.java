package com.lumara.servlet;

import com.lumara.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/rooms")
public class RoomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Map<String, Object>> rooms = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM rooms ORDER BY id ASC")) {

            while (rs.next()) {
                Map<String, Object> room = new HashMap<>();
                room.put("id", rs.getInt("id"));
                room.put("room_type", rs.getString("room_type"));
                room.put("price", rs.getBigDecimal("price"));
                room.put("capacity", rs.getInt("capacity"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/admin/manage_rooms.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (!"admin".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        try (Connection conn = DBConnection.getConnection()) {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String sql = "DELETE FROM rooms WHERE id = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, id);
                    pstmt.executeUpdate();
                }
            } else {
                // Add or Update
                String roomType = request.getParameter("room_type");
                BigDecimal price = new BigDecimal(request.getParameter("price"));
                int capacity = Integer.parseInt(request.getParameter("capacity"));
                String idStr = request.getParameter("id");

                if (idStr == null || idStr.isEmpty()) {
                    // Add
                    String sql = "INSERT INTO rooms (room_type, price, capacity) VALUES (?, ?, ?)";
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        pstmt.setString(1, roomType);
                        pstmt.setBigDecimal(2, price);
                        pstmt.setInt(3, capacity);
                        pstmt.executeUpdate();
                    }
                } else {
                    // Update
                    int id = Integer.parseInt(idStr);
                    String sql = "UPDATE rooms SET room_type = ?, price = ?, capacity = ? WHERE id = ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        pstmt.setString(1, roomType);
                        pstmt.setBigDecimal(2, price);
                        pstmt.setInt(3, capacity);
                        pstmt.setInt(4, id);
                        pstmt.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }
}
