<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% if (request.getAttribute("roomPrices")==null) { response.sendRedirect(request.getContextPath() + "/rooms" );
        return; } %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Rooms & Suites – Lumara Resort</title>
            <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
        </head>

        <body>
            <jsp:include page="navbar.jsp" />

            <!-- Hero Section -->
            <section class="rooms-hero">
                <h1>Accommodations</h1>
                <p>Sanctuary for the Soul</p>
            </section>

            <!-- Room Details Container -->
            <div class="room-details-container">

                <!-- Standard Room Section -->
                <div id="standard" class="room-detail-section">
                    <div class="room-detail-image">
                        <img src="<%= request.getContextPath() %>/images/standard_room.png"
                            alt="Standard Room at Lumara Resort" />
                    </div>
                    <div class="room-detail-content">
                        <h2>Standard Room</h2>
                        <p class="room-description">
                            Experience comfort and elegance in our Standard Rooms. Perfect for couples or solo
                            travelers,
                            these rooms offering a serene retreat with stunning views of the lush tropical gardens or
                            the
                            glistening ocean. Designed with a blend of modern amenities and traditional island charm.
                        </p>

                        <div class="room-specs">
                            <div class="spec-item">
                                <span class="spec-icon">👥</span>
                                <span class="spec-label">2 Guests</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">📐</span>
                                <span class="spec-label">45 m²</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">🛏️</span>
                                <span class="spec-label">Queen Bed</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">🌊</span>
                                <span class="spec-label">Ocean View</span>
                            </div>
                        </div>

                        <div class="room-subsection">
                            <h3>Highlights</h3>
                            <ul class="amenities-list">
                                <li>Private Balcony</li>
                                <li>Air Conditioning</li>
                                <li>Free High-Speed Wi-Fi</li>
                                <li>Rain Shower</li>
                                <li>Daily Housekeeping</li>
                            </ul>
                        </div>

                        <div class="room-subsection">
                            <h3>Included Activities</h3>
                            <ul class="activities-tags">
                                <li>Snorkeling</li>
                                <li>Island Hopping</li>
                                <li>Spa & Wellness</li>
                                <li>Beachfront Dining</li>
                            </ul>
                        </div>

                        <div class="room-footer">
                            <div class="price-tag">
                                <span class="currency">RM</span>
                                <span class="amount">${roomPrices['standard'] != null ? roomPrices['standard'] :
                                    '350'}</span>
                                <span class="duration">/ night</span>
                            </div>
                            <a href="<%= request.getContextPath() %>/booking.jsp?room=standard" class="btn-primary">Book
                                This Room</a>
                        </div>
                    </div>
                </div>

                <!-- Deluxe Room Section (Reverse Layout) -->
                <div id="deluxe" class="room-detail-section reverse">
                    <div class="room-detail-image">
                        <img src="<%= request.getContextPath() %>/images/deluxe_room.png"
                            alt="Deluxe Room at Lumara Resort" />
                    </div>
                    <div class="room-detail-content">
                        <h2>Deluxe Room</h2>
                        <p class="room-description">
                            Elevate your stay in our Deluxe Rooms. Featuring direct beachfront access, a spacious
                            layout,
                            and premium furnishings, this is the ideal choice for those seeking extra luxury. Enjoy your
                            morning coffee on your expansive private terrace while listening to the waves.
                        </p>

                        <div class="room-specs">
                            <div class="spec-item">
                                <span class="spec-icon">👥</span>
                                <span class="spec-label">3 Guests</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">📐</span>
                                <span class="spec-label">60 m²</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">🛏️</span>
                                <span class="spec-label">King Bed</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">🏖️</span>
                                <span class="spec-label">Beachfront</span>
                            </div>
                        </div>

                        <div class="room-subsection">
                            <h3>Highlights</h3>
                            <ul class="amenities-list">
                                <li>Direct Beach Access</li>
                                <li>Spacious Private Terrace</li>
                                <li>Mini Bar & Coffee Machine</li>
                                <li>Luxury Bath Amenities</li>
                                <li>Smart TV</li>
                            </ul>
                        </div>

                        <div class="room-subsection">
                            <h3>Included Activities</h3>
                            <p class="included-note">Includes all Standard activities, plus:</p>
                            <ul class="activities-tags">
                                <li class="highlight">Night Diving</li>
                                <li class="highlight">Scuba Diving</li>
                            </ul>
                        </div>

                        <div class="room-footer">
                            <div class="price-tag">
                                <span class="currency">RM</span>
                                <span class="amount">${roomPrices['deluxe'] != null ? roomPrices['deluxe'] :
                                    '550'}</span>
                                <span class="duration">/ night</span>
                            </div>
                            <a href="<%= request.getContextPath() %>/booking.jsp?room=deluxe" class="btn-primary">Book
                                This
                                Room</a>
                        </div>
                    </div>
                </div>

                <!-- Family Suite Section -->
                <div id="family" class="room-detail-section">
                    <div class="room-detail-image">
                        <img src="<%= request.getContextPath() %>/images/family_suite_empty.png"
                            alt="Family Suite at Lumara Resort" />
                    </div>
                    <div class="room-detail-content">
                        <h2>Family Suite</h2>
                        <p class="room-description">
                            Your home away from home. The Family Suite is designed for ultimate comfort and bonding.
                            With
                            separate living areas, a kitchenette, and two bedrooms, there's space for everyone to relax.
                            Experience the pinnacle of island luxury with panoramic ocean views.
                        </p>

                        <div class="room-specs">
                            <div class="spec-item">
                                <span class="spec-icon">👨‍👩‍👧‍👦</span>
                                <span class="spec-label">6 Guests</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">📐</span>
                                <span class="spec-label">120 m²</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">🛏️</span>
                                <span class="spec-label">2 King Beds</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-icon">🌅</span>
                                <span class="spec-label">Panoramic View</span>
                            </div>
                        </div>

                        <div class="room-subsection">
                            <h3>Highlights</h3>
                            <ul class="amenities-list">
                                <li>Two Separate Bedrooms</li>
                                <li>Living & Dining Area</li>
                                <li>Fully Equipped Kitchenette</li>
                                <li>Jacuzzi Bathtub</li>
                                <li>PlayStation & Board Games</li>
                            </ul>
                        </div>

                        <div class="room-subsection">
                            <h3>Included Activities</h3>
                            <p class="included-note">Includes all Deluxe activities, plus:</p>
                            <ul class="activities-tags">
                                <li class="highlight">Jungle Tracking</li>
                                <li class="highlight">ATV Tours</li>
                                <li class="highlight">Sunset Cruise</li>
                            </ul>
                        </div>

                        <div class="room-footer">
                            <div class="price-tag">
                                <span class="currency">RM</span>
                                <span class="amount">${roomPrices['family suite'] != null ? roomPrices['family suite'] :
                                    '750'}</span>
                                <span class="duration">/ night</span>
                            </div>
                            <a href="<%= request.getContextPath() %>/booking.jsp?room=family" class="btn-primary">Book
                                This
                                Room</a>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Comparison Section -->
            <section class="comparison-section">
                <h2>Compare Your Stay</h2>
                <div class="comparison-table-wrapper">
                    <table class="comparison-table">
                        <thead>
                            <tr>
                                <th>Feature</th>
                                <th>Standard Room</th>
                                <th>Deluxe Room</th>
                                <th>Family Suite</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Price per Night</td>
                                <td>RM ${roomPrices['standard'] != null ? roomPrices['standard'] : '350'}</td>
                                <td>RM ${roomPrices['deluxe'] != null ? roomPrices['deluxe'] : '550'}</td>
                                <td>RM ${roomPrices['family suite'] != null ? roomPrices['family suite'] : '750'}</td>
                            </tr>
                            <tr>
                                <td>Max Occupancy</td>
                                <td>2 Guests</td>
                                <td>3 Guests</td>
                                <td>6 Guests</td>
                            </tr>
                            <tr>
                                <td>Bed Configuration</td>
                                <td>1 Queen Bed</td>
                                <td>1 King Bed</td>
                                <td>2 King Beds</td>
                            </tr>
                            <tr>
                                <td>View</td>
                                <td>Ocean View</td>
                                <td>Beachfront</td>
                                <td>Panoramic Ocean</td>
                            </tr>
                            <tr>
                                <td>Breakfast Included</td>
                                <td>✅</td>
                                <td>✅</td>
                                <td>✅</td>
                            </tr>
                            <tr>
                                <td>Free Wi-Fi</td>
                                <td>✅</td>
                                <td>✅</td>
                                <td>✅</td>
                            </tr>
                            <tr>
                                <td>Private Balcony</td>
                                <td>✅</td>
                                <td>✅</td>
                                <td>✅</td>
                            </tr>
                            <tr>
                                <td>Bathtub</td>
                                <td>❌</td>
                                <td>✅</td>
                                <td>✅ (Jacuzzi)</td>
                            </tr>
                            <tr>
                                <td>Kitchenette</td>
                                <td>❌</td>
                                <td>❌</td>
                                <td>✅</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <jsp:include page="footer.jsp" />

        </body>

        </html>