package com.example.Controllers;

import com.example.DataBaseManager;
import com.example.service.UserAuthenticationServiceImplementation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserAuthenticationServiceImplementation userAuthenticationServiceImplementation;

    @Override
    public void init() throws ServletException {
        try {
            DataBaseManager dbManager = new DataBaseManager();
            Connection connection = dbManager.getConnection();
            userAuthenticationServiceImplementation = new UserAuthenticationServiceImplementation(connection);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize database connection.", e);
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            boolean isUser = userAuthenticationServiceImplementation.authenticateUser(username, password);

            if (isUser) {

                String userType = userAuthenticationServiceImplementation.getUserType(username);

                session.setAttribute("username", username);
                session.setAttribute("usertype", userType);
                session.setAttribute("validUser", true);


                if ("Student".equalsIgnoreCase(userType)) {
                    response.sendRedirect("student");
                } else if ("Admin".equalsIgnoreCase(userType)) {
                    response.sendRedirect("admin");
                } else if ("Instructor".equalsIgnoreCase(userType)) {
                    response.sendRedirect("instructor");
                } else {
                    response.sendRedirect("login.jsp");
                }
            } else {

                request.setAttribute("errorMessage", "Invalid Username or Password, Try Again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred.", e);
        }
    }

}

