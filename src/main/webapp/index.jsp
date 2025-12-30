<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Lumara Resort</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
</head>

<body>
  <jsp:include page="navbar.jsp" />

  <!-- Hero Section -->
  <section class="hero">
    <h1>Your Tropical Escape</h1>
    <p>Luxury. Nature. Comfort.</p>
  </section>

  <!-- Section 1: Activities Showcase -->
  <section class="activities-showcase">
    <h2>Discover Our Activities</h2>
    <p class="section-subtitle">Experience the best of tropical paradise</p>

    <div class="activity-grid">
      <div class="activity-card">
        <img src="<%= request.getContextPath() %>/images/activity-snorkeling.jpg" alt="Snorkeling" />
        <div class="activity-info">
          <h3>Snorkeling</h3>
          <p>Explore vibrant coral reefs and tropical marine life</p>
        </div>
      </div>

      <div class="activity-card">
        <img src="<%= request.getContextPath() %>/images/activity-island.jpg" alt="Island Hopping" />
        <div class="activity-info">
          <h3>Island Hopping</h3>
          <p>Discover pristine beaches and hidden coves</p>
        </div>
      </div>

      <div class="activity-card">
        <img src="<%= request.getContextPath() %>/images/activity-spa.jpg" alt="Spa & Wellness" />
        <div class="activity-info">
          <h3>Spa & Wellness</h3>
          <p>Rejuvenate with our luxury spa treatments</p>
        </div>
      </div>
    </div>

    <a href="<%= request.getContextPath() %>/activities.jsp" class="btn-primary">View All Activities</a>
  </section>

  <!-- Section 2: Room Selector -->
  <section class="room-selector">
    <h2>Our Rooms</h2>
    <p class="section-subtitle">Choose your perfect accommodation</p>

    <div class="room-tabs">
      <button class="room-tab" onclick="switchRoomTab('standard')">Standard</button>
      <button class="room-tab" onclick="switchRoomTab('deluxe')">Deluxe</button>
      <button class="room-tab" onclick="switchRoomTab('family')">Family Suite</button>
    </div>

    <div class="room-contents">
      <div id="standard" class="room-content">
        <div class="room-image">
          <img src="<%= request.getContextPath() %>/images/room1.jpg" alt="Standard Room" />
        </div>
        <div class="room-details">
          <h3>Standard Room</h3>
          <ul class="room-features">
            <li>Ocean view</li>
            <li>Queen-size bed</li>
            <li>Private balcony</li>
            <li>Air conditioning</li>
            <li>Free Wi-Fi</li>
          </ul>
          <div class="room-activities-header">Included Activities:</div>
          <ul class="room-activities">
            <li>Snorkeling</li>
            <li>Island Hopping</li>
            <li>Spa and Wellness</li>
            <li>Beachfront Dining</li>
          </ul>
          <a href="<%= request.getContextPath() %>/rooms.jsp#standard" class="btn-secondary">Room Information</a>
        </div>
      </div>

      <div id="deluxe" class="room-content">
        <div class="room-image">
          <img src="<%= request.getContextPath() %>/images/room2.jpg" alt="Deluxe Room" />
        </div>
        <div class="room-details">
          <h3>Deluxe Room</h3>
          <ul class="room-features">
            <li>Beachfront access</li>
            <li>King-size bed</li>
            <li>Spacious balcony</li>
            <li>Mini bar</li>
            <li>Premium amenities</li>
          </ul>
          <div class="room-activities-header">Included Activities:</div>
          <ul class="room-activities">
            <li>Snorkeling, Island Hopping</li>
            <li>Spa and Wellness, Beachfront Dining</li>
            <li><strong>Night Diving</strong></li>
            <li><strong>Scuba Diving</strong></li>
          </ul>
          <a href="<%= request.getContextPath() %>/rooms.jsp#deluxe" class="btn-secondary">Room Information</a>
        </div>
      </div>

      <div id="family" class="room-content">
        <div class="room-image">
          <img src="<%= request.getContextPath() %>/images/room3.jpg" alt="Family Suite" />
        </div>
        <div class="room-details">
          <h3>Family Suite</h3>
          <ul class="room-features">
            <li>Two bedrooms</li>
            <li>Living area</li>
            <li>Kitchenette</li>
            <li>Sleeps up to 6</li>
            <li>Premium ocean view</li>
          </ul>
          <div class="room-activities-header">Included Activities:</div>
          <ul class="room-activities">
            <li>All Deluxe Room Activities</li>
            <li><strong>Jungle Tracking</strong></li>
            <li><strong>ATV Tours</strong></li>
            <li><strong>Sunset Cruise</strong></li>
          </ul>
          <a href="<%= request.getContextPath() %>/rooms.jsp#family" class="btn-secondary">Room Information</a>
        </div>
      </div>
    </div>
  </section>

  <!-- Section 3: FAQ -->
  <section class="faq-section">
    <h2>Frequently Asked Questions</h2>
    <p class="section-subtitle">Everything you need to know</p>

    <div class="faq-container">
      <div class="faq-item">
        <div class="faq-question" onclick="toggleFAQ(this)">
          <h3>What are the check-in and check-out times?</h3>
          <span class="faq-icon">+</span>
        </div>
        <div class="faq-answer">
          <p>Check-in time is 2:00 PM and check-out time is 12:00 PM (noon). Early check-in and late check-out are
            subject to availability and may incur additional charges. Please contact us in advance to arrange.</p>
        </div>
      </div>

      <div class="faq-item">
        <div class="faq-question" onclick="toggleFAQ(this)">
          <h3>What activities are included with my room?</h3>
          <span class="faq-icon">+</span>
        </div>
        <div class="faq-answer">
          <p>Activities vary by room type. Standard Rooms include snorkeling, island hopping, spa & wellness, and
            beachfront dining. Deluxe Rooms add night diving and scuba diving. Family Suites include all Deluxe
            activities plus jungle tracking, ATV tours, and sunset cruise. Check our Rooms section for full details.</p>
        </div>
      </div>

      <div class="faq-item">
        <div class="faq-question" onclick="toggleFAQ(this)">
          <h3>How do I get to Lumara Resort?</h3>
          <span class="faq-icon">+</span>
        </div>
        <div class="faq-answer">
          <p>We offer complimentary speedboat transfers from the mainland jetty. The scenic 45-minute journey departs
            daily at 10:00 AM, 2:00 PM, and 6:00 PM. Please provide your arrival details at least 24 hours in advance so
            we can arrange your transfer.</p>
        </div>
      </div>

      <div class="faq-item">
        <div class="faq-question" onclick="toggleFAQ(this)">
          <h3>What's included in the room rate?</h3>
          <span class="faq-icon">+</span>
        </div>
        <div class="faq-answer">
          <p>All rooms include free Wi-Fi, air conditioning, daily housekeeping, complimentary breakfast buffet, beach
            towels, access to our infinity pool and private beach, and selected activities based on your room type.
            Minibar items and premium dining are charged separately.</p>
        </div>
      </div>

      <div class="faq-item">
        <div class="faq-question" onclick="toggleFAQ(this)">
          <h3>Is the resort suitable for families with children?</h3>
          <span class="faq-icon">+</span>
        </div>
        <div class="faq-answer">
          <p>Absolutely! Our Family Suites are designed for families with spacious accommodations sleeping up to 6
            guests. We offer kid-friendly activities, a children's pool area, and our beachfront is perfect for safe
            swimming. Children under 12 stay free when sharing with parents.</p>
        </div>
      </div>

      <div class="faq-item">
        <div class="faq-question" onclick="toggleFAQ(this)">
          <h3>What is your cancellation policy?</h3>
          <span class="faq-icon">+</span>
        </div>
        <div class="faq-answer">
          <p>Free cancellation up to 7 days before check-in. Cancellations made within 7 days will be charged 50% of the
            total booking. Cancellations within 48 hours or no-shows will be charged the full reservation amount.</p>
        </div>
      </div>
    </div>
  </section>

  <jsp:include page="footer.jsp" />

  <script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>

</html>