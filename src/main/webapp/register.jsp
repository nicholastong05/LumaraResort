<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <title>Register – Lumara Resort</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
    </head>

    <body>
        <jsp:include page="navbar.jsp" />

        <section class="login-container">
            <h2>Create Account</h2>

            <!-- REGISTER FORM -->
            <form method="post" action="<%= request.getContextPath() %>/register">
                <p>
                    Username:<br />
                    <input type="text" name="username" required />
                </p>

                <p>
                    Password:<br />
                    <input type="password" name="password" required />
                </p>



                <button type="submit">Sign Up</button>
            </form>

            <!-- ERROR MESSAGE -->
            <% if (request.getParameter("error") !=null) { %>
                <p style="color: red">Registration failed. Username may already exist.</p>
                <% } %>

                    <p class="login-note">
                        Already have an account? <a href="login.jsp">Log in here</a>
                    </p>
        </section>

        <jsp:include page="footer.jsp" />
    </body>

    </html>