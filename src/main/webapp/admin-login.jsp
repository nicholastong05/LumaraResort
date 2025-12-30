<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <title>Admin Login – Lumara Resort</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
  </head>

  <body>
    <jsp:include page="navbar.jsp" />

    <header class="navbar">
      <div class="logo">Admin – Lumara Resort</div>
    </header>
    <section class="highlights">
      <h2>Admin Login</h2>

      <form>
        <p>
          Username:<br />
          <input type="text" required />
        </p>
        <p>
          Password:<br />
          <input type="password" required />
        </p>
        <button type="submit">Login</button>
      </form>
    </section>
    <jsp:include page="footer.jsp" />
  </body>

  </html>