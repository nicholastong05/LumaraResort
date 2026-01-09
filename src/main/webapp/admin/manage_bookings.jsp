<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Bookings</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css">
    
    <style> /*
   ADMIN BOOKINGS TABLE
  */

.admin-table {
    width: 90%;
    margin: 40px auto;
    border-collapse: separate;
    border-spacing: 0;
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 14px 35px rgba(0,0,0,0.08);
}

.admin-table th {
    background: #0a3d62;
    color: white;
    padding: 16px;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.admin-table td {
    padding: 16px;
    text-align: center;
    border-bottom: 1px solid #eee;
    font-size: 15px;
}

.admin-table tr:last-child td {
    border-bottom: none;
}

.admin-table tbody tr:hover {
    background: #f3f8ff;
}


/* 
   ACTION BUTTONS
    */

.action-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
}

.btn-edit {
    padding: 7px 16px;
    border-radius: 10px;
    border: 1px solid #2563eb;
    background: white;
    color: #2563eb;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-edit:hover {
    background: #2563eb;
    color: white;
}

.btn-delete {
    padding: 7px 16px;
    border-radius: 10px;
    border: 1px solid #dc2626;
    color: #dc2626;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.2s ease;
}

.btn-delete:hover {
    background: #dc2626;
    color: white;
}
/* 
   EDIT MODAL
   */

.modal {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.55);
    justify-content: center;
    align-items: center;
    z-index: 2000;
}

.modal-content {
    background: white;
    width: 600px;
    max-width: 90%;
    padding: 30px 40px;
    border-radius: 16px;
    box-shadow: 0 30px 60px rgba(0,0,0,0.25);
}

.modal-content h3 {
    margin-top: 0;
    margin-bottom: 20px;
    font-size: 22px;
    color: #0a3d62;
}

.modal-content label {
    display: block;
    margin-top: 15px;
    font-weight: 600;
}

.modal-content input,
.modal-content select {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border-radius: 10px;
    border: 1px solid #ccc;
}

.modal-content button {
    margin-top: 25px;
    padding: 12px;
    width: 100%;
    background: #0a3d62;
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
}

.modal-content button:hover {
    background: #1e5a7a;
}

.close-btn {
    float: right;
    font-size: 26px;
    cursor: pointer;
}

/* ADMIN BOOKINGS */

.admin-title {
    text-align: center;
    margin: 40px 0 20px;
    font-size: 28px;
    color: #0a3d62;
}
/* Past bookings styling */
.past-booking {
    background: #f2f2f2 !important;
    color: #999;
}

.past-booking td {
    color: #999;
}

.past-booking .btn-edit {
    opacity: 0.4;
    cursor: not-allowed;
    pointer-events: none;
}

.past-label {
    font-size: 13px;
    font-weight: 600;
    color: #888;
}

</style>
</head>

<body>

<jsp:include page="../navbar.jsp" />

<h2 class="admin-title">All Bookings</h2>
<jsp:useBean id="now" class="java.util.Date" />
<table class="admin-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Room Type</th>
            <th>Check In</th>
            <th>Check Out</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
    </thead>

    <tbody>
    <c:forEach var="b" items="${bookingList}">
        <tr class="${b.checkOut.time lt now.time ? 'past-booking' : ''}">

            <td>${b.id}</td>
            <td>${b.name}</td>
            <td>${b.roomType}</td>

            <td>
                <fmt:formatDate value="${b.checkIn}" pattern="yyyy-MM-dd"/>
            </td>

            <td>
                <fmt:formatDate value="${b.checkOut}" pattern="yyyy-MM-dd"/>
            </td>

            <td>${b.createdAt}</td>

            <td>
    <div class="action-buttons">

        <c:if test="${b.checkOut.time ge now.time}">
            <button type="button"
                    class="btn-edit edit-btn"
                    data-id="${b.id}"
                    data-name="${b.name}"
                    data-room="${b.roomType}"
                    data-checkin="<fmt:formatDate value='${b.checkIn}' pattern='yyyy-MM-dd'/>"
                    data-checkout="<fmt:formatDate value='${b.checkOut}' pattern='yyyy-MM-dd'/>">
                Edit
            </button>

            <a class="btn-delete"
               href="<%= request.getContextPath() %>/admin/bookings/delete?id=${b.id}"
               onclick="return confirm('Delete this booking?');">
                Delete
            </a>
        </c:if>

    </div>

    <c:if test="${b.checkOut.time lt now.time}">
        <div class="past-label">Inactive booking </div>
    </c:if>
</td>

        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- EDIT MODAL -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeEdit()">×</span>

        <h3>Edit Booking</h3>

        <form method="post"
              action="<%= request.getContextPath() %>/admin/bookings/edit">

            <input type="hidden" name="id" id="edit-id">

            <label>Name</label>
            <input type="text" name="name" id="edit-name" required>

            <label>Room Type</label>
            <select name="roomType" id="edit-room" required>
                <c:forEach var="rt" items="${roomTypes}">
                    <option value="${rt}">${rt}</option>
                </c:forEach>
            </select>



            <label>Check In</label>
            <input type="date" name="checkIn" id="edit-checkin" required>

            <label>Check Out</label>
            <input type="date" name="checkOut" id="edit-checkout" required>

            <button type="submit" class="btn-save">Save Changes</button>
        </form>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {

    const editModal = document.getElementById("editModal");
    const editId = document.getElementById("edit-id");
    const editName = document.getElementById("edit-name");
    const editRoom = document.getElementById("edit-room");
    const editCheckin = document.getElementById("edit-checkin");
    const editCheckout = document.getElementById("edit-checkout");

    document.querySelectorAll(".edit-btn").forEach(btn => {
        btn.addEventListener("click", () => {

            editModal.style.display = "flex";

            editId.value = btn.dataset.id;
            editName.value = btn.dataset.name;
            editRoom.value = btn.dataset.room;
            editCheckin.value = btn.dataset.checkin;
            editCheckout.value = btn.dataset.checkout;
        });
    });
});

function closeEdit() {
    document.getElementById("editModal").style.display = "none";
}
</script>


</body>
</html>
