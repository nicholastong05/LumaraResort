package com.lumara.servlet;

import com.lumara.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/rooms")
public class PublicRoomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Double> roomPrices = new HashMap<>();
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT room_type, price FROM rooms")) {

            while (rs.next()) {
                roomPrices.put(rs.getString("room_type").toLowerCase(), rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("roomPrices", roomPrices);
        request.getRequestDispatcher("/rooms.jsp").forward(request, response);
    }
}
