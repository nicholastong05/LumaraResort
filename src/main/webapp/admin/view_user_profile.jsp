<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_v2.css">

    <style>
        /* ===============================
           ADMIN USER PROFILE (SAFE)
           =============================== */

        .admin-user-profile {
            max-width: 720px;
            margin: 60px auto;
            padding: 0 16px;
            animation: fadeIn 0.6s ease;
        }

        .admin-user-profile .profile-card {
            background: #ffffff;
            padding: 40px;
            border-radius: 22px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.12);
        }

        .admin-user-profile .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .admin-user-profile .profile-title {
            font-size: 26px;
            font-weight: 700;
            color: #0a3d62;
        }

        /* ===== ROLE PILL ===== */
        .admin-user-profile .role-pill {
            padding: 6px 16px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 700;
            text-transform: capitalize;
            white-space: nowrap;
        }

        .admin-user-profile .role-user {
            background: #dbeafe;
            color: #1e40af;
        }

        .admin-user-profile .role-admin {
            background: #fde68a;
            color: #92400e;
        }

        /* ===== DETAILS GRID ===== */
        .admin-user-profile .profile-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px 26px;
        }

        .admin-user-profile .profile-item {
            background: #f8fafc;
            padding: 16px 18px;
            border-radius: 14px;
        }

        .admin-user-profile .profile-label {
            font-size: 11px;
            letter-spacing: 0.6px;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .admin-user-profile .profile-value {
            font-size: 16px;
            font-weight: 600;
            color: #0f172a;
            word-break: break-word;
        }

        /* ===== ACTIONS ===== */
        .admin-user-profile .actions {
            margin-top: 40px;
        }

        .admin-user-profile .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 22px;
            border-radius: 999px;
            background: #0a3d62;
            color: #ffffff;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.25s ease;
        }

        .admin-user-profile .btn-back:hover {
            background: #08324f;
            transform: translateX(-4px);
        }

        /* ===== ANIMATION ===== */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(14px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>

<jsp:include page="../navbar.jsp"/>

<div class="admin-user-profile">

    <div class="profile-card">

        <!-- HEADER -->
        <div class="profile-header">
            <div class="profile-title">User Details</div>
            <div class="role-pill ${user['role'] == 'admin' ? 'role-admin' : 'role-user'}">
                ${user['role']}
            </div>
        </div>

        <!-- DETAILS -->
        <div class="profile-grid">

            <div class="profile-item">
                <div class="profile-label">Username</div>
                <div class="profile-value">${user['username']}</div>
            </div>

            <div class="profile-item">
                <div class="profile-label">Full Name</div>
                <div class="profile-value">${user['full_name']}</div>
            </div>

            <div class="profile-item">
                <div class="profile-label">Email</div>
                <div class="profile-value">${user['email']}</div>
            </div>

            <div class="profile-item">
                <div class="profile-label">Phone</div>
                <div class="profile-value">${user['phone']}</div>
            </div>

            <div class="profile-item">
                <div class="profile-label">Gender</div>
                <div class="profile-value">${user['gender']}</div>
            </div>

            <div class="profile-item">
                <div class="profile-label">Date of Birth</div>
                <div class="profile-value">${user['date_of_birth']}</div>
            </div>

        </div>

        <!-- ACTIONS -->
        <div class="actions">
            <a href="${pageContext.request.contextPath}/admin/users" class="btn-back">
                ← Back to User Management
            </a>
        </div>

    </div>
</div>

</body>
</html>
