package com.lumara.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String bookingIdStr = request.getParameter("bookingId");

        if (bookingIdStr == null || action == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdStr);

        if ("cancel".equals(action)) {
            cancelBooking(bookingId, response);
        }
        else if ("confirm".equals(action)) {
            confirmPayment(response);
        }
        else {
            response.sendRedirect("index.jsp");
        }
    }

    private void cancelBooking(int bookingId, HttpServletResponse response) throws IOException {
        try (Connection conn = com.lumara.util.DBConnection.getConnection()) {

            String sql = "DELETE FROM bookings WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, bookingId);
                pstmt.executeUpdate();
            }

            // Redirect user after cancellation
            response.sendRedirect("booking.jsp?cancelled=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=cancel_failed");
        }
    }

    private void confirmPayment(HttpServletResponse response) throws IOException {
        // Phase 1: no real payment logic yet
        response.sendRedirect("payment_success.jsp");
    }
}

