<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <title>Activities – Lumara Resort</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style_v2.css" />
  </head>

  <body>
    <!-- Shared Navbar -->
    <jsp:include page="navbar.jsp" />

    <!-- Hero Section for Activities -->
    <section class="activities-hero">
      <h1>Resort Activities</h1>
      <p>Unforgettable experiences await you</p>
    </section>

    <!-- All Activities Showcase -->
    <section class="activities-showcase">
      <h2>Explore Our Activities</h2>
      <p class="section-subtitle">Choose your adventure in paradise</p>

      <div class="activity-grid">
        <!-- Snorkeling -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-snorkeling.jpg" alt="Snorkeling" />
          <div class="activity-info">
            <h3>Snorkeling</h3>
            <p>Explore vibrant coral reefs and tropical marine life in crystal-clear waters. Perfect for beginners and
              experienced snorkelers alike.</p>
          </div>
        </div>

        <!-- Island Hopping -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-island.jpg" alt="Island Hopping" />
          <div class="activity-info">
            <h3>Island Hopping</h3>
            <p>Discover pristine beaches and hidden coves across multiple islands. Includes lunch and refreshments on a
              private beach.</p>
          </div>
        </div>

        <!-- Spa & Wellness -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-spa.jpg" alt="Spa & Wellness" />
          <div class="activity-info">
            <h3>Spa & Wellness</h3>
            <p>Rejuvenate with our luxury spa treatments including massages, facials, and aromatherapy in a tranquil
              setting.</p>
          </div>
        </div>

        <!-- Beachfront Dining -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-dining.jpg" alt="Beachfront Dining" />
          <div class="activity-info">
            <h3>Beachfront Dining</h3>
            <p>Savor gourmet cuisine with ocean views. Enjoy fresh seafood and international dishes prepared by our
              expert chefs.</p>
          </div>
        </div>

        <!-- Scuba Diving -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-diving.jpg" alt="Scuba Diving" />
          <div class="activity-info">
            <h3>Scuba Diving</h3>
            <p>Dive deep into the ocean and explore underwater caves and marine ecosystems. Certified instructors
              included.</p>
          </div>
        </div>

        <!-- Sunset Cruise -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-cruise.png" alt="Sunset Cruise" />
          <div class="activity-info">
            <h3>Sunset Cruise</h3>
            <p>Experience breathtaking sunsets on a luxury yacht. Includes champagne, canapés, and live music.</p>
          </div>
        </div>

        <!-- Night Diving (NEW) -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-night-diving.png" alt="Night Diving" />
          <div class="activity-info">
            <h3>Night Diving</h3>
            <p>Witness the ocean come to life after dark. Discover nocturnal sea creatures and glowing plankton in a
              magical underwater world.</p>
          </div>
        </div>

        <!-- Jungle Tracking (NEW) -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-jungle.png" alt="Jungle Tracking" />
          <div class="activity-info">
            <h3>Jungle Tracking</h3>
            <p>Embark on an adventurous trek through lush tropical rainforests. Guided tours to scenic viewpoints and
              hidden waterfalls.</p>
          </div>
        </div>

        <!-- ATV Tours (NEW) -->
        <div class="activity-card">
          <img src="<%= request.getContextPath() %>/images/activity-atv.png" alt="ATV Tours" />
          <div class="activity-info">
            <h3>ATV Tours</h3>
            <p>Feel the thrill of off-road exploration on our powerful ATVs. Navigate muddy trails and forest paths for
              an adrenaline-packed experience.</p>
          </div>
        </div>
      </div>
    </section>

    <jsp:include page="footer.jsp" />

    <script src="<%= request.getContextPath() %>/js/main.js"></script>
  </body>

  </html>