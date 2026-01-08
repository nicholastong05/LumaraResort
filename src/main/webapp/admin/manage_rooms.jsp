<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <title>Manage Rooms – Lumara Resort</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_v2.css" />
            <style>
                .rooms-container {
                    max-width: 1000px;
                    margin: 40px auto;
                    padding: 20px;
                    background: rgba(255, 255, 255, 0.9);
                    border-radius: 20px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                }

                .rooms-table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                }

                .rooms-table th,
                .rooms-table td {
                    padding: 15px;
                    text-align: left;
                    border-bottom: 1px solid #eee;
                }

                .rooms-table th {
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
                }

                .edit-btn {
                    background: #0a3d62;
                    color: white;
                }

                .edit-btn:hover {
                    background: #0056b3;
                }

                .delete-btn {
                    background: #e74c3c;
                    color: white;
                    margin-left: 5px;
                }

                .delete-btn:hover {
                    background: #c0392b;
                }

                .add-room-form {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 15px;
                    margin-top: 30px;
                    padding: 20px;
                    background: #f8f9fa;
                    border-radius: 15px;
                }

                .add-room-form input {
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
            </style>
        </head>

        <body>
            <jsp:include page="../navbar.jsp" />

            <div class="rooms-container">
                <h2>Room Management</h2>

                <table class="rooms-table">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Price (MYR)</th>
                            <th>Daily Capacity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="room" items="${rooms}">
                            <tr>
                                <td>${room.room_type}</td>
                                <td>${room.price}</td>
                                <td>${room.capacity}</td>
                                <td>
                                    <button class="action-btn edit-btn"
                                        onclick="editRoom('${room.id}', '${room.room_type}', '${room.price}', '${room.capacity}')">Edit</button>
                                    <form action="${pageContext.request.contextPath}/admin/rooms" method="POST"
                                        style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${room.id}">
                                        <button type="submit" class="action-btn delete-btn"
                                            onclick="return confirm('Delete this room type?')">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div id="roomFormSection">
                    <h3 id="formTitle">Add New Room Type</h3>
                    <form action="${pageContext.request.contextPath}/admin/rooms" method="POST" class="add-room-form">
                        <input type="hidden" name="id" id="roomId">
                        <input type="text" name="room_type" id="roomType" placeholder="Room Type (e.g. Deluxe)"
                            required>
                        <input type="number" name="price" id="roomPrice" step="0.01" placeholder="Price per night"
                            required>
                        <input type="number" name="capacity" id="roomCapacity" placeholder="Daily Capacity" required>
                        <button type="submit" class="submit-btn" id="submitBtn">Add Room</button>
                        <button type="button" class="action-btn" onclick="resetForm()" id="cancelBtn"
                            style="display:none; background:#95a5a6; color:white;">Cancel</button>
                    </form>
                </div>
            </div>

            <script>
                function editRoom(id, type, price, capacity) {
                    document.getElementById('roomId').value = id;
                    document.getElementById('roomType').value = type;
                    document.getElementById('roomPrice').value = price;
                    document.getElementById('roomCapacity').value = capacity;
                    document.getElementById('formTitle').innerText = 'Edit Room Type';
                    document.getElementById('submitBtn').innerText = 'Update Room';
                    document.getElementById('cancelBtn').style.display = 'inline-block';
                }

                function resetForm() {
                    document.getElementById('roomId').value = '';
                    document.getElementById('roomType').value = '';
                    document.getElementById('roomPrice').value = '';
                    document.getElementById('roomCapacity').value = '';
                    document.getElementById('formTitle').innerText = 'Add New Room Type';
                    document.getElementById('submitBtn').innerText = 'Add Room';
                    document.getElementById('cancelBtn').style.display = 'none';
                }
            </script>

            <jsp:include page="../footer.jsp" />
        </body>

        </html>