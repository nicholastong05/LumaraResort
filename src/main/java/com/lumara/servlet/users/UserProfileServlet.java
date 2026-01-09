package com.lumara.servlet.users;

import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/account/profile")
public class UserProfileServlet extends HttpServlet {

    @Override
    public void init() {
    System.out.println("UserProfileServlet LOADED");
}

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

            // Auto-create profile if missing
            String insertProfile =
                "INSERT INTO user_profiles (user_id) " +
                "VALUES (?) " +
                "ON CONFLICT (user_id) DO NOTHING";

            try (PreparedStatement ps = conn.prepareStatement(insertProfile)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }

            // Fetch profile
            String sql =
                "SELECT u.username, u.role, " +
                "p.full_name, p.email, p.phone, p.gender, p.date_of_birth " +
                "FROM users u " +
                "LEFT JOIN user_profiles p ON u.id = p.user_id " +
                "WHERE u.id = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("username", rs.getString("username"));
                    request.setAttribute("role", rs.getString("role"));
                    request.setAttribute("fullName", rs.getString("full_name"));
                    request.setAttribute("email", rs.getString("email"));
                    request.setAttribute("phone", rs.getString("phone"));
                    request.setAttribute("gender", rs.getString("gender"));
                    request.setAttribute("dob", rs.getDate("date_of_birth"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/account/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                "UPDATE user_profiles " +
                "SET full_name = ?, email = ?, phone = ?, gender = ?, date_of_birth = ? " +
                "WHERE user_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, request.getParameter("fullName"));
                ps.setString(2, request.getParameter("email"));
                ps.setString(3, request.getParameter("phone"));
                ps.setString(4, request.getParameter("gender"));

                String dob = request.getParameter("dob");
                if (dob == null || dob.isEmpty()) {
                    ps.setNull(5, Types.DATE);
                } else {
                    ps.setDate(5, Date.valueOf(dob));
                }

                ps.setInt(6, userId);
                ps.executeUpdate();
            }

            session.setAttribute("profileSuccess", "Profile updated successfully.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("profileError", "Failed to update profile.");
        }

        response.sendRedirect(request.getContextPath() + "/account/profile");
    }
}
