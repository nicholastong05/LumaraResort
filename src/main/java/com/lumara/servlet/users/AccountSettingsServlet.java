package com.lumara.servlet.users;

import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/account/settings")
public class AccountSettingsServlet extends HttpServlet {

    /* =========================
       LOAD SETTINGS PAGE
       ========================= */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT username FROM users WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("username", rs.getString("username"));
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/account/settings.jsp")
               .forward(request, response);
    }

    /* =========================
       HANDLE UPDATES
       ========================= */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("username".equals(action)) {
            updateUsername(request, session, userId);
        }
        else if ("password".equals(action)) {
            updatePassword(request, session, userId);
        }

        response.sendRedirect(request.getContextPath() + "/account/settings");
    }

    /* =========================
       UPDATE USERNAME
       ========================= */
    private void updateUsername(HttpServletRequest request,
                                HttpSession session,
                                Integer userId) {

        String newUsername = request.getParameter("newUsername");

        if (newUsername == null || newUsername.trim().isEmpty()) {
            session.setAttribute("settingsError", "Username cannot be empty.");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "UPDATE users SET username = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, newUsername.trim());
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            session.setAttribute("settingsSuccess", "Username updated successfully.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("settingsError", "Failed to update username.");
        }
    }

    /* =========================
       UPDATE PASSWORD
       ========================= */
    private void updatePassword(HttpServletRequest request,
                                HttpSession session,
                                Integer userId) {

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        if (oldPassword == null || newPassword == null ||
            oldPassword.isEmpty() || newPassword.isEmpty()) {

            session.setAttribute("settingsError", "All password fields are required.");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String fetchSql = "SELECT password FROM users WHERE id = ?";
            String dbPassword = null;

            try (PreparedStatement ps = conn.prepareStatement(fetchSql)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        dbPassword = rs.getString("password");
                    }
                }
            }

            if (dbPassword == null || !dbPassword.equals(oldPassword)) {
                session.setAttribute("settingsError", "Incorrect current password.");
                return;
            }

            String updateSql = "UPDATE users SET password = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                ps.setString(1, newPassword);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            session.setAttribute("settingsSuccess", "Password updated successfully.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("settingsError", "Failed to update password.");
        }
    }
}
