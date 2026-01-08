package com.lumara.servlet.admin;

import com.lumara.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Map<String, Object>> users = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT id, username, role FROM users ORDER BY id ASC")) {

            while (rs.next()) {
                Map<String, Object> user = new HashMap<>();
                user.put("id", rs.getInt("id"));
                user.put("username", rs.getString("username"));
                user.put("role", rs.getString("role"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/manage_users.jsp").forward(request, response);
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
        String currentAdmin = (String) request.getSession().getAttribute("username");

        try (Connection conn = DBConnection.getConnection()) {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String usernameToDelete = request.getParameter("username");

                if (currentAdmin != null && currentAdmin.equals(usernameToDelete)) {
                    request.getSession().setAttribute("error", "You cannot delete your own account.");
                } else {
                    String sql = "DELETE FROM users WHERE id = ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        pstmt.setInt(1, id);
                        pstmt.executeUpdate();
                        request.getSession().setAttribute("message", "User deleted successfully.");
                    }
                }
            } else if ("add".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String userRole = request.getParameter("role");

                String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    pstmt.setString(3, userRole);
                    pstmt.executeUpdate();
                    request.getSession().setAttribute("message", "User added successfully.");
                }
            } else if ("update_role".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String newRole = request.getParameter("role");

                String sql = "UPDATE users SET role = ? WHERE id = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, newRole);
                    pstmt.setInt(2, id);
                    pstmt.executeUpdate();
                    request.getSession().setAttribute("message", "User role updated successfully.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Database error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
