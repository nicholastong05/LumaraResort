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
import java.sql.Statement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("username") == null) {
            response.sendRedirect("login.jsp?error=login_required");
            return;
        }

        String name = request.getParameter("name");
        String roomType = request.getParameter("room_type");
        String checkInStr = request.getParameter("check_in");
        String checkOutStr = request.getParameter("check_out");

        // Basic validation
        if (name == null || name.trim().isEmpty()
                || checkInStr == null || checkOutStr == null) {
            response.sendRedirect("booking.jsp?error=missing_fields");
            return;
        }

        try {
            // Parse dates after validation
            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);

            long nights = ChronoUnit.DAYS.between(checkIn, checkOut);

            if (nights <= 0) {
                response.sendRedirect("booking.jsp?error=invalid_dates");
                return;
            }

            // Simple pricing logic (Phase 1)
            double pricePerNight;
            switch (roomType) {
                case "Deluxe":
                    pricePerNight = 550;
                    break;
                case "Family Suite":
                    pricePerNight = 750;
                    break;
                default:
                    pricePerNight = 350;
            }

            double totalAmount = nights * pricePerNight;

            try (Connection conn = com.lumara.util.DBConnection.getConnection()) {

                String sql = "INSERT INTO bookings (name, room_type, check_in, check_out) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                    pstmt.setString(1, name);
                    pstmt.setString(2, roomType);
                    pstmt.setDate(3, Date.valueOf(checkInStr));
                    pstmt.setDate(4, Date.valueOf(checkOutStr));

                    pstmt.executeUpdate();

                    // Retrieve generated booking ID
                    int bookingId = -1;
                    ResultSet rs = pstmt.getGeneratedKeys();
                    if (rs.next()) {
                        bookingId = rs.getInt(1);
                    }

                    // Pass data to payment page
                    request.setAttribute("bookingId", bookingId);
                    request.setAttribute("name", name);
                    request.setAttribute("roomType", roomType);
                    request.setAttribute("checkIn", checkInStr);
                    request.setAttribute("checkOut", checkOutStr);
                    request.setAttribute("nights", nights);
                    request.setAttribute("totalAmount", totalAmount);

                    // Forward to payment page
                    request.getRequestDispatcher("payment.jsp")
                            .forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=db_error");
        }
    }
}
