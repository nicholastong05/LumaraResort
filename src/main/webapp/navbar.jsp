<% String username = (String) session.getAttribute("username"); %>

<header class="navbar">
  <div class="logo">Lumara Resort</div>
  <nav>
    <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/rooms.jsp">Rooms</a>
    <a href="<%= request.getContextPath() %>/activities.jsp">Activities</a>

    <a href="<%= request.getContextPath() %>/booking.jsp">Book Now</a>

    <% if (username == null) { %>
    <a href="<%= request.getContextPath() %>/login.jsp">Log in</a>
    <% } else { %>
    <span>Welcome, <%= username %></span>
    <a href="<%= request.getContextPath() %>/logout">Logout</a>
    <% } %>
  </nav>
</header>
