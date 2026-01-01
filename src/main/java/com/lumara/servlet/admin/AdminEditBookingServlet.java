package com.lumara.servlet.admin;

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
import java.sql.Date;

@WebServlet("/admin/bookings/edit")
public class AdminEditBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Security: admin-only
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String roomType = request.getParameter("roomType");
            Date checkIn = Date.valueOf(request.getParameter("checkIn"));
            Date checkOut = Date.valueOf(request.getParameter("checkOut"));

            //  Date validation
            if (!checkOut.after(checkIn)) {
                response.sendRedirect(
                        request.getContextPath() + "/admin/bookings?error=invalid_dates"
                );
                return;
            }

           String sql =
           "UPDATE bookings " +
           "SET name = ?, room_type = ?, check_in = ?, check_out = ? " +
           "WHERE id = ?";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, name);
                ps.setString(2, roomType);
                ps.setDate(3, checkIn);
                ps.setDate(4, checkOut);
                ps.setInt(5, id);

                ps.executeUpdate();
            }

            // back to bookings list
            response.sendRedirect(request.getContextPath() + "/admin/bookings");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                    request.getContextPath() + "/admin/bookings?error=edit_failed"
            );
        }
    }
}
