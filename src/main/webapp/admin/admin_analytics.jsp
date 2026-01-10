<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Analytics</title>
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style_v2.css">
    <style>

/* Page entrance animation */
.admin-container {
    animation: analyticsFade 0.7s ease both;
}

@keyframes analyticsFade {
    from {
        opacity: 0;
        transform: translateY(16px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Title styling */
.admin-container h2 {
    font-size: 36px;
    font-weight: 800;
    margin-bottom: 40px;
    color: #0a3d62;
    letter-spacing: 1px;
    position: relative;
}

.admin-container h2::after {
    content: "";
    width: 80px;
    height: 4px;
    background: linear-gradient(135deg, #2563eb, #667eea);
    display: block;
    margin: 14px auto 0;
    border-radius: 999px;
}

/* Cards layout refinement */
.admin-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 32px;
    max-width: 1000px;
    margin: 0 auto;
}

/* Individual stat card */
.admin-card {
    background: linear-gradient(145deg, #ffffff, #f1f5f9);
    padding: 36px 28px;
    border-radius: 26px;
    text-align: center;
    position: relative;
    overflow: hidden;
    cursor: default;

    box-shadow:
        0 18px 40px rgba(0, 0, 0, 0.12);

    transition:
        transform 0.35s ease,
        box-shadow 0.35s ease;
}

/* Accent glow bar */
.admin-card::before {
    content: "";
    position: absolute;
    inset: 0;
    border-radius: 26px;
    padding: 2px;
    background: linear-gradient(
        135deg,
        transparent,
        rgba(37, 99, 235, 0.6),
        transparent
    );
    -webkit-mask:
        linear-gradient(#fff 0 0) content-box,
        linear-gradient(#fff 0 0);
    -webkit-mask-composite: xor;
    mask-composite: exclude;
    opacity: 0;
    transition: opacity 0.35s ease;
}

/* Hover lift + glow */
.admin-card:hover {
    transform: translateY(-12px) scale(1.03);
    box-shadow:
        0 28px 60px rgba(37, 99, 235, 0.25);
}

.admin-card:hover::before {
    opacity: 1;
}

/* Card heading */
.admin-card h3 {
    font-size: 18px;
    font-weight: 700;
    color: #374151;
    margin-bottom: 18px;
    text-transform: uppercase;
    letter-spacing: 1.2px;
}

/* Stat number */
.admin-card p {
    font-size: 42px;
    font-weight: 800;
    margin: 0;
    background: linear-gradient(135deg, #2563eb, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Revenue currency tweak */
.admin-card p::before {
    content: "";
}

/* Subtle floating animation */
.admin-card {
    animation: floatCard 6s ease-in-out infinite;
}

@keyframes floatCard {
    0% { transform: translateY(0); }
    50% { transform: translateY(-6px); }
    100% { transform: translateY(0); }
}

/* Responsive tweaks */
@media (max-width: 768px) {
    .admin-container h2 {
        font-size: 28px;
    }

    .admin-card p {
        font-size: 34px;
    }
}

    </style>
</head>
<body>

<jsp:include page="../navbar.jsp" />

<div class="admin-container">
    <h2>Admin Analytics</h2>

    <div class="admin-cards">

        <div class="admin-card">
            <h3>Total Users</h3>
            <p><%= request.getAttribute("totalUsers") %></p>
        </div>

        <div class="admin-card">
            <h3>Total Bookings</h3>
            <p><%= request.getAttribute("totalBookings") %></p>
        </div>

        <div class="admin-card">
            <h3>Total Revenue</h3>
            <p>RM <%= request.getAttribute("totalRevenue") %></p>
        </div>

    </div>
</div>

<jsp:include page="../footer.jsp" />

</body>
</html>
