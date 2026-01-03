<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Log in – Lumara Resort</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
  </head>

  <body>
    <jsp:include page="navbar.jsp" />

    <div class="login-page-bg">
      <div class="login-card">
        <h2>Welcome Back</h2>

        <!-- FEEDBACK MESSAGES -->
        <% if (request.getParameter("registered") !=null) { %>
          <div class="feedback-message feedback-success">
            Registration successful! Please log in.
          </div>
          <% } %>

            <% String error=request.getParameter("error"); if (error !=null) { %>
              <div class="feedback-message feedback-error">
                <%= "login_required" .equals(error) ? "Please log in before booking." : "Invalid username or password"
                  %>
              </div>
              <% } %>

                <!-- LOGIN FORM -->
                <form method="post" action="<%= request.getContextPath() %>/login">
                  <div class="login-form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required />
                  </div>

                  <div class="login-form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required />
                  </div>

                  <button type="submit" class="btn-login">Log in</button>
                </form>

                <div class="login-links">
                  <p>Don't have an account? <a href="register.jsp">Register here</a></p>
                </div>

                <div style="margin-top: 15px; font-size: 13px; color: #888;">
                  (Same login for users and admins)
                </div>
      </div>
    </div>

    <jsp:include page="footer.jsp" />
  </body>

  </html>