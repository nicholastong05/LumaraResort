<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>User Login – Lumara Resort</title>
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
        <a href="booking.jsp">Book Now</a>
      </nav>
    </header>

    <section class="login-container">
      <h2>User Login</h2>

      <form>
        <p>
          Email:<br />
          <input type="email" required />
        </p>
        <p>
          Password:<br />
          <input type="password" required />
        </p>
        <button type="submit">Login</button>
      </form>

      <p class="login-note">Admin? <a href="admin-login.html">Login here</a></p>
    </section>

    <footer>
      <p>© 2025 Lumara Resort</p>
    </footer>
  </body>
</html>
