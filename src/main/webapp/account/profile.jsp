<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Account Overview</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_v2.css">

    <style>
        .account-wrapper {
            display: flex;
            max-width: 1200px;
            margin: 50px auto;
            gap: 30px;
        }

        /* Sidebar */
        .account-sidebar {
            width: 260px;
        }

        .account-user {
            margin-bottom: 30px;
        }

        .account-user h3 {
            margin: 0;
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

        .account-menu a:hover {
            background: #eef3f7;
        }

        .logout-link {
            margin-top: 20px;
            color: #b91c1c;
        }

        .logout-link:hover {
            background: #fee2e2;
        }

        /* Content */
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
        }

        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 25px;
        }

        .profile-grid label {
            font-size: 13px;
            color: #666;
        }

        .profile-grid input,
        .profile-grid select {
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

        .btn-secondary {
            background: #e5e7eb;
            color: #111;
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
        /* edit button*/
    .btn-edit {
        padding: 6px 14px;
        font-size: 14px;
        border-radius: 999px;
        background: transparent;
        border: 1.5px solid #0a3d62;
        color: #0a3d62;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.2s ease;
    }

   .btn-edit:hover {
       background: #0a3d62;
       color: white;
    }
    /* save button*/
    .btn-save {
        padding: 6px 14px;
        font-size: 14px;
        border-radius: 999px;
        background: transparent;
        border: 1.5px solid #0d942a;
        color: #0d942a;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.2s ease;
    }

   .btn-save:hover {
       background: #0d942a;
       color: white;
    }

    </style>
</head>

<body>

<jsp:include page="../navbar.jsp" />

<div class="account-wrapper">

    <!-- SIDEBAR -->
    <div class="account-sidebar">
        <div class="account-user">
            <h3>${username}</h3>
            <small>${email}</small>
        </div>

        <div class="account-menu">
            <a href="${pageContext.request.contextPath}/account/profile" class="active">
                Account Overview
            </a>

            <a href="${pageContext.request.contextPath}/account/bookings">
                My Bookings
            </a>

            <a href="${pageContext.request.contextPath}/account/cards">
                Payment Methods
            </a>

            <a href="${pageContext.request.contextPath}/account/settings">
                Settings
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                Sign out
            </a>
        </div>
    </div>

    <!-- CONTENT -->
    <div class="account-content">

        <c:if test="${not empty sessionScope.profileSuccess}">
            <div class="alert alert-success">
                ${sessionScope.profileSuccess}
                <c:remove var="profileSuccess" scope="session"/>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.profileError}">
            <div class="alert alert-error">
                ${sessionScope.profileError}
                <c:remove var="profileError" scope="session"/>
            </div>
        </c:if>

        <div class="profile-card">

            <div class="profile-header">
                <h2>Basic Information</h2>
                <button type="button" class="btn-edit" onclick="enableEdit()">
                    Edit Profile
                </button>

            </div>

            <form method="post" action="${pageContext.request.contextPath}/account/profile">

                <div class="profile-grid">

                    <div>
                        <label>Display Name</label>
                        <input type="text" name="fullName" value="${fullName}" disabled>
                    </div>

                    <div>
                        <label>Email</label>
                        <input type="email" name="email" value="${email}" disabled>
                    </div>

                    <div>
                        <label>Phone</label>
                        <input type="text" name="phone" value="${phone}" disabled>
                    </div>

                    <div>
                        <label>Gender</label>
                        <select name="gender" disabled>
                            <option value="">Select</option>
                            <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
                        </select>
                    </div>

                    <div>
                        <label>Date of Birth</label>
                        <input type="date" name="dob" value="${dob}" disabled>
                    </div>

                </div>

                <br>

                <button type="submit" class="btn-save" id="saveBtn" style="display:none;">
                    Save Changes
                </button>


            </form>

        

        </div>
    </div>

</div>

<jsp:include page="../footer.jsp" />

<script>
function enableEdit() {
    const fields = document.querySelectorAll(
        ".profile-grid input, .profile-grid select"
    );

    fields.forEach(field => {
        field.disabled = false;
    });

    document.getElementById("saveBtn").style.display = "inline-block";

    // Hide Edit button
    document.querySelector(".btn-edit").style.display = "none";
}
</script>


</body>
</html>
