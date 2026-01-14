<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <% if (session.getAttribute("username")==null) { response.sendRedirect("login.jsp?error=login_required"); return; } %>
    <!DOCTYPE html>
    <html>

    <head>
      <title>Booking – Lumara Resort</title>
      <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
    </head>

    <body>
      <jsp:include page="navbar.jsp" />

      <header class="booking-hero">
        <h1>Book Your Stay</h1>
        <p>Luxury and comfort await you at Lumara Resort</p>
      </header>

      <div class="booking-container">
        <% String success=request.getParameter("success"); String error=request.getParameter("error"); if
          ("true".equals(success)) { %>
          <div
            style="background: #d4edda; color: #155724; padding: 15px; border-radius: 12px; margin-bottom: 20px; text-align: center; border: 1px solid #c3e6cb;">
            Booking confirmed! We look forward to see you.
          </div>
          <% } else if (error !=null) { %>
            <div
              style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 12px; margin-bottom: 20px; text-align: center; border: 1px solid #f5c6cb;">
              <% if ("room_full".equals(error)) { %>
                Room full for the selected dates. Please try another date or room type.
                <% } else if ("invalid_dates".equals(error)) { %>
                  Invalid dates selected. Check-out must be after check-in.
                  <% } else if ("missing_fields".equals(error)) { %>
                    Please fill in all required fields.
                    <% } else if ("invalid_room_type".equals(error)) { %>
                      Selected room type is not available.
                      <% } else if ("db_error".equals(error)) { %>
                        A database error occurred. Please try again later.
                        <% } else if ("invalid_card_cancelled".equals(error)) { %>
    Booking Cancelled: Invalid card details provided.
                          <% } else { %>
                            Something went wrong. Please check your details.
                            <% } %>
            </div>
            <% } %>

              <form class="booking-form" action="<%= request.getContextPath() %>/book" method="POST">
                <div class="form-group">
                  <label for="name">Full Name</label>
                  <input type="text" id="name" name="name" placeholder="Enter your full name" required />
                </div>

                <div class="form-group">
                  <label for="room-type">Room Type</label>
                  <select id="room-type" name="room_type">
                    <option value="Standard">Standard</option>
                    <option value="Deluxe">Deluxe</option>
                    <option value="Family Suite">Family Suite</option>
                  </select>
                </div>

                <div class="form-group">
                  <label for="check-in">Check-in Date</label>
                  <input type="date" id="check-in" name="check_in" required />
                </div>

                <div class="form-group">
                  <label for="check-out">Check-out Date</label>
                  <input type="date" id="check-out" name="check_out" required />
                </div>

                <button type="submit" class="btn-booking">Confirm Booking</button>
              </form>
      </div>

      <jsp:include page="footer.jsp" />
      <script src="js/validation.js"></script>
    </body>

    </html>