<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background-color: #9e9e9e; /* grey background */
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, Helvetica, sans-serif;
        }

        .success-card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 40px 50px;
            text-align: center;
            width: 420px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        .check-circle {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            border: 4px solid #22c55e;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 20px auto;
        }

        .check-circle span {
            color: #22c55e;
            font-size: 36px;
            font-weight: bold;
        }

        .success-card h2 {
            margin: 10px 0 30px 0;
            color: #000;
            font-weight: 600;
        }

        .btn-bookings {
            display: inline-block;
            width: 100%;
            padding: 14px 0;
            background-color: #0b0f19;
            color: #ffffff;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        .btn-bookings:hover {
            background-color: #1a1f2e;
        }
    </style>
</head>
<body>

    <div class="success-card">
        <div class="check-circle">
            <span>✓</span>
        </div>

        <h2>Your booking is confirmed</h2>

        <a href="<%= request.getContextPath() %>/account/userbooking.jsp"
        class="btn-bookings">
            Go to your bookings
        </a>


    </div>

</body>
</html>
