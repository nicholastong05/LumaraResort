package com.lumara.servlet.users;

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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/account/cards")
public class AccountCardsServlet extends HttpServlet {

    /* =========================
       GET: Load cards page
       ========================= */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        Integer userId = (session != null && session.getAttribute("userId") != null)
                ? (Integer) session.getAttribute("userId")
                : 2; // TEMP dev fallback

        List<Map<String, String>> cards = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                "SELECT payment_id, card_last4, cardholder_name, expiry_month, expiry_year " +
                "FROM user_payment_methods " +
                "WHERE user_id = ? " +
                "ORDER BY created_at DESC";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, String> card = new HashMap<>();
                        card.put("paymentId", rs.getString("payment_id"));
                        card.put("last4", rs.getString("card_last4"));
                        card.put("cardholderName", rs.getString("cardholder_name"));
                        card.put("expiryMonth", rs.getString("expiry_month"));
                        card.put("expiryYear", rs.getString("expiry_year"));
                        cards.add(card);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("cards", cards);
        request.getRequestDispatcher("/account/cards.jsp")
               .forward(request, response);
    }

    /* =========================
       POST: Add / Delete card
       ========================= */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        Integer userId = (session != null && session.getAttribute("userId") != null)
                ? (Integer) session.getAttribute("userId")
                : 2; // TEMP dev fallback

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCard(request, userId, session);
        } else if ("delete".equals(action)) {
            deleteCard(request, userId, session);
        }

        response.sendRedirect(request.getContextPath() + "/account/cards");
    }

    /* =========================
       ADD CARD
       ========================= */
    private void addCard(HttpServletRequest request, Integer userId, HttpSession session) {

        String cardNumber = request.getParameter("cardNumber");
        String cardholderName = request.getParameter("cardholderName");
        String expiryDate = request.getParameter("expiryDate"); // MM/YY

        if (cardNumber == null || cardNumber.length() < 4 || expiryDate == null) {
            session.setAttribute("cardError", "Invalid card details");
            return;
        }

        String last4 = cardNumber.substring(cardNumber.length() - 4);
        String expiryMonth = expiryDate.substring(0, 2);
        String expiryYear = "20" + expiryDate.substring(3, 5);

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                "INSERT INTO user_payment_methods " +
                "(user_id, card_brand, card_last4, cardholder_name, expiry_month, expiry_year) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setString(2, "Visa"); // hardcoded as requested
                ps.setString(3, last4);
                ps.setString(4, cardholderName);
                ps.setString(5, expiryMonth);
                ps.setString(6, expiryYear);
                ps.executeUpdate();
            }

            session.setAttribute("cardSuccess", "Card added successfully");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("cardError", "Failed to add card");
        }
    }

    /* =========================
       DELETE CARD
       ========================= */
    private void deleteCard(HttpServletRequest request, Integer userId, HttpSession session) {

        String paymentIdStr = request.getParameter("paymentId");

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                "DELETE FROM user_payment_methods " +
                "WHERE payment_id = ? AND user_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(paymentIdStr));
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            session.setAttribute("cardSuccess", "Card removed");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("cardError", "Failed to remove card");
        }
    }
}
