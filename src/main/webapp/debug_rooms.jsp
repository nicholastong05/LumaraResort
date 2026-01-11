<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html; charset=UTF-8" %>
        <html>

        <body>
            <h2>Debug Rooms Simple</h2>
            <% try { Class.forName("org.postgresql.Driver"); String
                url="jdbc:postgresql://ep-aged-dawn-a1oucbqp-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require"
                ; String user="neondb_owner" ; String pass="npg_YTOHMpIxCi49" ; try (Connection
                conn=DriverManager.getConnection(url, user, pass); Statement stmt=conn.createStatement(); ResultSet
                rs=stmt.executeQuery("SELECT * FROM rooms")) { out.println("<table border=1>");
                while(rs.next()) {
                out.println("<tr>");
                    out.println("<td>" + rs.getString("room_type") + "</td>");
                    out.println("<td>" + rs.getString("price") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                }
                } catch (Exception e) {
                out.println("Error: " + e);
                e.printStackTrace(new java.io.PrintWriter(out));
                }
                %>
        </body>

        </html>