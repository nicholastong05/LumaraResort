<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <title>Log in – Lumara Resort</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
  </head>

  <body>
    <jsp:include page="navbar.jsp" />

    <section class="login-container">
      <h2>Log in</h2>

      <!-- LOGIN FORM -->
      <form method="post" action="<%= request.getContextPath() %>/login">
        <p>
          Username:<br />
          <input type="text" name="username" required />
        </p>

        <p>
          Password:<br />
          <input type="password" name="password" required />
        </p>

        <button type="submit">Log in</button>
      </form>

      <!-- REGISTER SUCCESS MESSAGE -->
      <% if (request.getParameter("registered") !=null) { %>
        <p style="color: green">Registration successful! Please log in.</p>
        <% } %>

          <!-- LOGIN ERROR MESSAGE -->
          <% if (request.getParameter("error") !=null) { %>
            <p style="color: red">Invalid username or password</p>
            <% } %>

              <p class="login-note">
                Same login for <strong>users</strong> and <strong>admins</strong>
              </p>

              <p class="login-note">
                Don't have an account? <a href="register.jsp">Register here</a>
              </p>
    </section>

    <footer>
      <p>© 2025 Lumara Resort</p>
    </footer>
  </body>

  </html>