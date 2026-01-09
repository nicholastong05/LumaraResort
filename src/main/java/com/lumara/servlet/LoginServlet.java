package com.lumara.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        try (java.sql.Connection conn = com.lumara.util.DBConnection.getConnection()) {

            String sql = "SELECT id, role FROM users WHERE username = ? AND password = ?";

            try (java.sql.PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, username);
                pstmt.setString(2, password);

                try (java.sql.ResultSet rs = pstmt.executeQuery()) {

                    if (rs.next()) {
                        int userId = rs.getInt("id");
                        String role = rs.getString("role");

                        // REQUIRED session data
                        session.setAttribute("userId", userId);
                        session.setAttribute("username", username);
                        session.setAttribute("role", role);

                        if ("admin".equals(role)) {
                            response.sendRedirect("admin.jsp");
                        } else {
                            response.sendRedirect("index.jsp");
                        }

                    } else {
                        response.sendRedirect("login.jsp?error=1");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        }
    }
}
