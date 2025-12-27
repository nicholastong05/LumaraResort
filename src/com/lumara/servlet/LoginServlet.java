package com.lumara.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    HttpSession session = request.getSession();

    // TEMP LOGIC (later replace with DB)
    if ("admin".equals(username) && "admin123".equals(password)) {
      session.setAttribute("role", "admin");
      session.setAttribute("username", username);
      response.sendRedirect("admin.jsp");

    } else if ("user".equals(username) && "user123".equals(password)) {
      session.setAttribute("role", "user");
      session.setAttribute("username", username);
      response.sendRedirect("index.jsp");

    } else {
      response.sendRedirect("login.jsp?error=1");
    }
  }
}
