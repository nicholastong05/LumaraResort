<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>Manage Users – Lumara Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_v2.css" />
    <style>
        .users-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .users-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .users-table th,
        .users-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .users-table th {
            background-color: #f8f9fa;
            color: #0a3d62;
        }

        .action-btn {
            padding: 8px 16px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .delete-btn {
            background: #e74c3c;
            color: white;
        }

        .delete-btn:hover {
            background: #c0392b;
        }

        .role-btn {
            background: #0a3d62;
            color: white;
        }

        .role-btn:hover {
            background: #0056b3;
        }

        .add-user-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 15px;
        }

        .add-user-form input, .add-user-form select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .submit-btn {
            background: #27ae60;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 8px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #219150;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 8px;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
    </style>
</head>

<body>
    <jsp:include page="../navbar.jsp" />

    <div class="users-container">
        <h2>User Management</h2>

        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">
                ${sessionScope.message}
                <% session.removeAttribute("message"); %>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                ${sessionScope.error}
                <% session.removeAttribute("error"); %>
            </div>
        </c:if>

        <table class="users-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>
                            <span class="role-badge">${user.role}</span>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline;">
                                <input type="hidden" name="action" value="update_role">
                                <input type="hidden" name="id" value="${user.id}">
                                <input type="hidden" name="username" value="${user.username}">
                                <select name="role" onchange="this.form.submit()" style="padding: 5px; border-radius: 5px;">
                                    <option value="user" ${user.role == 'user' ? 'selected' : ''}>User</option>
                                    <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                                </select>
                            </form>
                            
                            <c:if test="${user.role == 'user'}">
                                <a href="${pageContext.request.contextPath}/admin/user/profile?id=${user.id}"
                                class="action-btn role-btn"
                                style="margin-left: 10px;">
                                View Profile</a>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/admin/users" method="POST" style="display:inline; margin-left: 10px;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${user.id}">
                                <input type="hidden" name="username" value="${user.username}">
                                <button type="submit" class="action-btn delete-btn" onclick="return confirm('Delete user ${user.username}?')">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="addUserSection">
            <h3>Add New User</h3>
            <form action="${pageContext.request.contextPath}/admin/users" method="POST" class="add-user-form">
                <input type="hidden" name="action" value="add">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <select name="role" required>
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>
                <button type="submit" class="submit-btn">Add User</button>
            </form>
        </div>
    </div>

    <jsp:include page="../footer.jsp" />
</body>

</html>
