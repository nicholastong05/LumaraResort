<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Activities – Lumara Resort</title>
    <meta charset="UTF-8" />
    <link
      rel="stylesheet"
      href="<%= request.getContextPath() %>/css/style.css"
    />
  </head>

  <body>
    <!-- Shared Navbar -->
    <jsp:include page="navbar.jsp" />

    <section class="highlights">
      <h2>Resort Activities</h2>
      <div class="cards">
        <div class="card">Snorkeling</div>
        <div class="card">Island Hopping</div>
        <div class="card">Spa & Wellness</div>
      </div>
    </section>

    <footer>
      <p>© 2025 Lumara Resort</p>
    </footer>
  </body>
</html>
