<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% String role=(String) session.getAttribute("role"); if (!"admin".equals(role)) {
        response.sendRedirect("login.jsp"); return; } %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <title>Admin Dashboard – Lumara Resort</title>
            <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
            <style>
                /* RESET BUTTON DEFAULT STYLES */
                button.admin-card {
                    all: unset;
                    /* removes ALL default button styles */
                    box-sizing: border-box;
                }

                /* ===== ADMIN DASHBOARD BUTTONS (GREY + OVAL) ===== */

                .admin-cards {
                    display: flex;
                    justify-content: center;
                    gap: 32px;
                    margin-top: 40px;
                }

                button.admin-card {
                    all: unset;
                    box-sizing: border-box;

                    width: 240px;
                    padding: 30px 26px;

                    /* MORE OVAL */
                    border-radius: 40px;

                    /* GREYER LOOK */
                    background: linear-gradient(135deg,
                            #f2f4f7 0%,
                            #e6e9ee 100%);

                    border: 1px solid rgba(0, 0, 0, 0.1);

                    text-align: center;
                    cursor: pointer;

                    box-shadow:
                        0 8px 18px rgba(0, 0, 0, 0.08);

                    transition:
                        transform 0.3s ease,
                        box-shadow 0.3s ease,
                        background 0.3s ease;
                }

                button.admin-card h3 {
                    margin: 0 0 10px;
                    font-size: 18px;
                    font-weight: 700;
                    color: #0a3d62;
                }

                button.admin-card p {
                    margin: 0;
                    font-size: 14px;
                    color: #444;
                    line-height: 1.5;
                }

                /* Hover = subtle premium lift */
                button.admin-card:hover {
                    transform: translateY(-8px);

                    background: linear-gradient(135deg,
                            #e9edf3 0%,
                            #dde2ea 100%);

                    box-shadow:
                        0 16px 32px rgba(0, 0, 0, 0.18);
                }

                /* Click feedback */
                button.admin-card:active {
                    transform: translateY(-4px);
                    box-shadow:
                        0 10px 20px rgba(0, 0, 0, 0.15);
                }

                .modal {
                    position: fixed;
                    inset: 0;
                    background: rgba(0, 0, 0, 0.4);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .modal-content {
                    background: white;
                    padding: 25px;
                    width: 400px;
                    border-radius: 12px;
                }

                .close-btn {
                    float: right;
                    cursor: pointer;
                    font-size: 20px;
                }
            </style>
        </head>

        <body>

            <jsp:include page="navbar.jsp" />

            <section class="admin-container">
                <h2>Admin Dashboard</h2>

                <div class="admin-cards">

                    <button class="admin-card"
                        onclick="window.location.href='<%= request.getContextPath() %>/admin/rooms'">
                        <h3>Manage Rooms</h3>
                        <p>Add, update, or remove rooms</p>
                    </button>

                    <button class="admin-card"
                        onclick="window.location.href='<%= request.getContextPath() %>/admin/bookings'">
                        <h3>View Bookings</h3>
                        <p>Check customer bookings</p>
                    </button>

                    <button class="admin-card"
                        onclick="window.location.href='<%= request.getContextPath() %>/admin/users'">
                        <h3>Manage Users</h3>
                        <p>View and manage accounts</p>
                    </button>

                </div>
            </section>

            <jsp:include page="footer.jsp" />

        </body>

        </html>