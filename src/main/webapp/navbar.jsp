<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
%>

<header class="navbar">
    <div class="logo">Lumara Resort</div>

    <nav>
        <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/rooms.jsp">Rooms</a>
        <a href="<%= request.getContextPath() %>/activities.jsp">Activities</a>
        <a href="<%= request.getContextPath() %>/booking.jsp">Book Now</a>

        <%-- ADMIN NAVIGATION --%>
        <% if ("admin".equals(role)) { %>
            <a href="<%= request.getContextPath() %>/admin.jsp" style="font-weight:600;">
                Admin Dashboard
            </a>
        <% } %>

        <%-- AUTH NAVIGATION --%>
        <% if (username == null) { %>
            <a href="<%= request.getContextPath() %>/login.jsp">Log in</a>
        <% } else { %>

            <%-- USER ONLY: My Account --%>
            <% if (!"admin".equals(role)) { %>
                <a href="<%= request.getContextPath() %>/account/profile">
                    My Account
                </a>
            <% } %>

            <span>Welcome, <%= username %></span>
            <a href="<%= request.getContextPath() %>/logout">Logout</a>

        <% } %>
    </nav>
</header>
