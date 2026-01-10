package com.lumara.servlet;

import com.lumara.util.CardValidator;
import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
            return;
        }

        if ("confirm".equals(action)) {

            // ---- CHECK IF USER USED NEW CARD ----
            String cardNumber = request.getParameter("cardNumber");
            String expiryDate = request.getParameter("expiryDate");
            String cvv = request.getParameter("cvv");

            if (cardNumber != null && !cardNumber.trim().isEmpty()) {

                // ✅ CENTRALIZED VALIDATION
                String validationError =
                        CardValidator.validate(cardNumber, expiryDate, cvv);

                if (validationError != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("paymentError", validationError);
                    response.sendRedirect("payment.jsp");
                    return;
                }
            }

            confirmPayment(response);
            return;
        }

        response.sendRedirect("index.jsp");
    }

    /* =========================
       CANCEL BOOKING
       ========================= */
    private void cancelBooking(int bookingId, HttpServletResponse response)
            throws IOException {

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "DELETE FROM bookings WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, bookingId);
                pstmt.executeUpdate();
            }

            response.sendRedirect("booking.jsp?cancelled=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?error=cancel_failed");
        }
    }

    /* =========================
       CONFIRM PAYMENT
       ========================= */
    private void confirmPayment(HttpServletResponse response)
            throws IOException {

        // Phase 1: simulated payment success
        response.sendRedirect("payment_success.jsp");
    }
}
