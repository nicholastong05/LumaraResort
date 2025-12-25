<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Booking – Lumara Resort</title>
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css"
    />
  </head>
  <body>
    <header class="navbar">
      <div class="logo">Lumara Resort</div>
      <nav>
        <a href="index.jsp">Home</a>
        <a href="rooms.jsp">Rooms</a>
        <a href="activities.html">Activities</a>
      </nav>
    </header>

    <section class="highlights">
      <h2>Book Your Stay</h2>

      <form onsubmit="return validateBooking()">
        <p>
          Name:<br />
          <input type="text" required />
        </p>
        <p>
          Room Type:<br />
          <select>
            <option>Standard</option>
            <option>Deluxe</option>
            <option>Family Suite</option>
          </select>
        </p>
        <p>
          Check-in Date:<br />
          <input type="date" required />
        </p>
        <p>
          Check-out Date:<br />
          <input type="date" required />
        </p>
        <button type="submit">Submit Booking</button>
      </form>
    </section>

    <footer>
      <p>© 2025 Lumara Resort</p>
    </footer>
    <script src="../js/validation.js"></script>
  </body>
</html>
