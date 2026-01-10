<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Methods</title>
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

        .card-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px;
            border-radius: 14px;
            border: 1px solid #e5e7eb;
            margin-bottom: 15px;
            background: #fff;
        }

        .card-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .card-icon {
            width: 44px;
            height: 32px;
            border-radius: 6px;
            background: #dbeafe;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-meta strong {
            display: block;
        }

        .card-meta small {
            color: #666;
        }

        .btn-add-card {
            width: 100%;
            padding: 16px;
            border-radius: 14px;
            border: 2px dashed #cbd5e1;
            background: transparent;
            cursor: pointer;
            font-weight: 500;
        }

        .btn-add-card:hover {
            background: #f8fafc;
        }

        /* Modal */
        .modal {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.4);
            display: none;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 20px;
            width: 420px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            margin: 0;
        }

        .modal-close {
            cursor: pointer;
            font-size: 20px;
        }

        .modal form label {
            display: block;
            margin-top: 15px;
            font-size: 13px;
        }

        .modal form input {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-top: 6px;
        }

        .modal-actions {
            display: flex;
            gap: 10px;
            margin-top: 25px;
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
            <a href="${pageContext.request.contextPath}/account/profile">
                Account Overview
            </a>

            <a href="${pageContext.request.contextPath}/account/bookings">
                My Bookings
            </a>

            <a href="${pageContext.request.contextPath}/account/cards" class="active">
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

        <c:if test="${not empty sessionScope.cardSuccess}">
            <div class="alert alert-success">
                ${sessionScope.cardSuccess}
                <c:remove var="cardSuccess" scope="session"/>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.cardError}">
            <div class="alert alert-error">
                ${sessionScope.cardError}
                <c:remove var="cardError" scope="session"/>
            </div>
        </c:if>

        <div class="profile-card">
            <h2>Payment Methods</h2>
            <p style="color:#555">Manage your saved payment methods</p>

            <!-- SAVED CARDS -->
            <c:forEach var="card" items="${cards}">
                <div class="card-item">
                    <div class="card-left">
                        <div class="card-icon">💳</div>
                        <div class="card-meta">
                            <strong>Visa •••• ${card.last4}</strong>
                            <small>${card.cardholderName} · Expires ${card.expiryMonth}/${card.expiryYear}</small>
                        </div>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/account/cards">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="paymentId" value="${card.paymentId}">
                        <button type="submit" style="background:none;border:none;cursor:pointer;">🗑️</button>
                    </form>
                </div>
            </c:forEach>

            <!-- ADD CARD -->
            <button class="btn-add-card" onclick="openModal()">
                ＋ Add New Card
            </button>
        </div>
    </div>
</div>

<!-- ADD CARD MODAL -->
<div class="modal" id="cardModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Add Card Details</h3>
            <span class="modal-close" onclick="closeModal()">×</span>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/account/cards">
            <input type="hidden" name="action" value="add">

            <label>Card Number</label>
            <input type="text" name="cardNumber">

            <label>Cardholder Name</label>
            <input type="text" name="cardholderName">

            <div style="display:flex; gap:10px;">
                <div style="flex:1">
                    <label>Expiry Date</label>
                    <input type="text" name="expiryDate" placeholder="MM/YY">
                </div>
                <div style="flex:1">
                    <label>CVV</label>
                    <input type="text" name="cvv">
                </div>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                <button type="submit" class="btn btn-primary">Add Card</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../footer.jsp" />

<script>
function openModal() {
    document.getElementById("cardModal").style.display = "flex";
}
function closeModal() {
    document.getElementById("cardModal").style.display = "none";
}
</script>

</body>
</html>
