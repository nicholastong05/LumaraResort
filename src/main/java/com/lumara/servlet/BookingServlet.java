package com.lumara.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String roomType = request.getParameter("room_type");
        String checkInStr = request.getParameter("check_in");
        String checkOutStr = request.getParameter("check_out");

        // Basic validation
        if (name == null || name.trim().isEmpty() || checkInStr == null || checkOutStr == null) {
            response.sendRedirect("booking.jsp?error=missing_fields");
            return;
        }

        try (Connection conn = com.lumara.util.DBConnection.getConnection()) {
            String sql = "INSERT INTO bookings (name, room_type, check_in, check_out) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, roomType);
                pstmt.setDate(3, Date.valueOf(checkInStr));
                pstmt.setDate(4, Date.valueOf(checkOutStr));

                pstmt.executeUpdate();

                // Success
                response.sendRedirect("booking.jsp?success=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=db_error");
        }
    }
}
