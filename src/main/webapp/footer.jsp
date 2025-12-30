<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <footer class="clean-footer">
        <div class="footer-container">
            <div class="footer-left">
                <h3>Lumara Resort</h3>
                <p>&copy; 2025 Lumara Resort.</p>
                <p class="contact-info">Contact Us: +60 14-631-9902</p>
            </div>

            <div class="footer-right">
                <div class="footer-col">
                    <h4>Details</h4>
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/index.jsp">Home</a></li>
                        <li><a href="<%= request.getContextPath() %>/rooms.jsp">Rooms</a></li>
                        <li><a href="<%= request.getContextPath() %>/activities.jsp">Activities</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h4>Social</h4>
                    <ul>
                        <li><a href="#">Instagram</a></li>
                        <li><a href="#">Facebook</a></li>
                        <li><a href="#">Twitter</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>