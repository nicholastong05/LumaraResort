package com.lumara.servlet.admin;

import com.lumara.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/user/profile")
public class AdminViewUserProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Admin check
        String role = (String) request.getSession().getAttribute("role");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                "SELECT u.username, u.role, " +
                "p.full_name, p.email, p.phone, p.gender, p.date_of_birth " +
                "FROM users u " +
                "LEFT JOIN user_profiles p ON u.id = p.user_id " +
                "WHERE u.id = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {

                        Map<String, Object> user = new HashMap<>();
                        user.put("username", rs.getString("username"));
                        user.put("role", rs.getString("role"));
                        user.put("full_name", rs.getString("full_name"));
                        user.put("email", rs.getString("email"));
                        user.put("phone", rs.getString("phone"));
                        user.put("gender", rs.getString("gender"));
                        user.put("date_of_birth", rs.getDate("date_of_birth"));

                        request.setAttribute("user", user);

                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/users");
                        return;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        

        request.getRequestDispatcher("/admin/view_user_profile.jsp")
               .forward(request, response);
    }
}
