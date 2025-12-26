<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Rooms – Lumara Resort</title>

    <!-- CSS -->
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css"
    />
  </head>

  <body>
    <jsp:include page="navbar.jsp" />

    <section class="highlights">
      <h2>Our Rooms</h2>

      <div class="cards">
        <div class="card">
          <img
            src="<%= request.getContextPath() %>/images/room1.jpg"
            alt="Standard Room"
          />
          <h3>Standard Room</h3>
          <p>RM 350 / night</p>
        </div>

        <div class="card">
          <img
            src="<%= request.getContextPath() %>/images/room2.jpg"
            alt="Deluxe Room"
          />
          <h3>Deluxe Room</h3>
          <p>RM 550 / night</p>
        </div>

        <div class="card">
          <img
            src="<%= request.getContextPath() %>/images/room3.jpg"
            alt="Family Suite"
          />
          <h3>Family Suite</h3>
          <p>RM 750 / night</p>
        </div>
      </div>
    </section>

    <footer>
      <p>© 2025 Lumara Resort</p>
    </footer>
  </body>
</html>
