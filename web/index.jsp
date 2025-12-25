<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Lumara Resort</title>
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
        <a href="booking.jsp">Book Now</a>
        <a href="admin.jsp">Admin</a>
      </nav>
    </header>

    <section class="hero">
      <h1>Your Tropical Escape</h1>
      <p>Luxury • Nature • Comfort</p>
    </section>

    <section class="highlights">
      <h2>Why Choose Lumara Resort?</h2>
      <div class="cards">
        <div class="card">Beachfront Rooms</div>
        <div class="card">Island Activities</div>
        <div class="card">All-Inclusive Packages</div>
      </div>
    </section>

    <footer>
      <p>© 2025 Lumara Resort. All rights reserved.</p>
    </footer>
  </body>
</html>
