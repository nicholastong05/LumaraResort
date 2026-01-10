<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Account Settings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_v2.css">

    <style>
        .account-wrapper {
            display: flex;
            max-width: 1200px;
            margin: 50px auto;
            gap: 30px;
        }

        .account-sidebar {
            width: 260px;
        }

        .account-menu a {
            display: block;
            padding: 12px;
            margin-bottom: 8px;
            border-radius: 10px;
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }

        .account-menu a.active {
            background: #0a3d62;
            color: white;
        }

        .account-menu a:not(.active):hover {
            background: #eef3f7; /* light hover */
            color: #333;
        }

        .account-menu a:hover {
            background: #000000;
        }

        .account-content {
            flex: 1;
            background: #f8fafc;
            padding: 30px;
            border-radius: 20px;
        }

        .profile-card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            font-size: 13px;
            color: #555;
        }

        input {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            font-weight: 500;
        }

        .btn-primary {
            background: #0a3d62;
            color: white;
        }

        .alert {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 10px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>

<body>

<jsp:include page="../navbar.jsp" />

<div class="account-wrapper">

    <!-- SIDEBAR -->
    <div class="account-sidebar">
        <div class="account-menu">
            <a href="${pageContext.request.contextPath}/account/profile">Account Overview</a>
            <a href="${pageContext.request.contextPath}/account/userbooking">My Bookings</a>
            <a href="${pageContext.request.contextPath}/account/cards">Payment Methods</a>
            <a href="${pageContext.request.contextPath}/account/settings" class="active">Settings</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">Sign out</a>
        </div>
    </div>

    <!-- CONTENT -->
    <div class="account-content">

        <c:if test="${not empty sessionScope.settingsSuccess}">
            <div class="alert alert-success">
                ${sessionScope.settingsSuccess}
                <c:remove var="settingsSuccess" scope="session"/>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.settingsError}">
            <div class="alert alert-error">
                ${sessionScope.settingsError}
                <c:remove var="settingsError" scope="session"/>
            </div>
        </c:if>

        <!-- CHANGE USERNAME -->
        <div class="profile-card">
            <h3>Change Username</h3>

            <form method="post" action="${pageContext.request.contextPath}/account/settings">
                <input type="hidden" name="action" value="username">

                <div class="form-group">
                    <label>New Username</label>
                    <input type="text" name="newUsername" value="${username}">
                </div>

                <button class="btn btn-primary" type="submit">
                    Update Username
                </button>
            </form>
        </div>

        <!-- CHANGE PASSWORD -->
<div class="profile-card">
    <h3>Change Password</h3>

    <form method="post"
          action="${pageContext.request.contextPath}/account/settings"
          autocomplete="off">

        <input type="hidden" name="action" value="password">

        <div class="form-group">
            <label>Current Password</label>
            <input type="password"
                   name="oldPassword"
                   value=""
                   autocomplete="current-password">
        </div>

        <div class="form-group">
            <label>New Password</label>
            <input type="password"
                   name="newPassword"
                   value=""
                   autocomplete="new-password">
        </div>

        <button class="btn btn-primary" type="submit">
            Update Password
        </button>
    </form>
</div>


<jsp:include page="../footer.jsp" />

</body>
</html>
