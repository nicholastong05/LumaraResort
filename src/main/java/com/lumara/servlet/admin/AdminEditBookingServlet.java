@WebServlet("/admin/bookings/edit")
public class AdminEditBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

            if (!checkOut.after(checkIn)) {
                response.sendRedirect(
                        request.getContextPath() + "/admin/bookings?error=invalid_dates"
                );
                return;
            }

            try (Connection conn = DBConnection.getConnection()) {

                //  Validate room exists
                String roomCheckSql = "SELECT COUNT(*) FROM rooms WHERE room_type = ?";
                try (PreparedStatement checkPs = conn.prepareStatement(roomCheckSql)) {
                    checkPs.setString(1, roomType);
                    var rs = checkPs.executeQuery();
                    if (rs.next() && rs.getInt(1) == 0) {
                        response.sendRedirect(
                                request.getContextPath() + "/admin/bookings?error=invalid_room"
                        );
                        return;
                    }
                }

                // Update booking
                String updateSql =
                        "UPDATE bookings " +
                        "SET name = ?, room_type = ?, check_in = ?, check_out = ? " +
                        "WHERE id = ?";

                try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                    ps.setString(1, name);
                    ps.setString(2, roomType);
                    ps.setDate(3, checkIn);
                    ps.setDate(4, checkOut);
                    ps.setInt(5, id);
                    ps.executeUpdate();
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/bookings");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                    request.getContextPath() + "/admin/bookings?error=edit_failed"
            );
        }
    }
}
