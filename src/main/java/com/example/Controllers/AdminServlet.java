package com.example.Controllers;

import com.example.DataBaseManager;
import com.example.dao.AdminDAOImplement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private AdminDAOImplement adminService;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            DataBaseManager dbManager = new DataBaseManager();
            Connection connection = dbManager.getConnection();
            adminService = new AdminDAOImplement(connection);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize database connection.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String usertype = (String) session.getAttribute("usertype");
        Boolean validUser = (Boolean) session.getAttribute("validUser");

        if (validUser != null && validUser && "Admin".equalsIgnoreCase(usertype)) {
            request.setAttribute("activeTab", "createUser");
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String activeTab = request.getParameter("activeTab");

        if ("createUser".equals(action)) {
            createUser(request, response);
            activeTab = "createUser";
        } else if ("createCourse".equals(action)) {
            createCourse(request, response);
            activeTab = "createCourse";
        } else if ("enrollStudent".equals(action)) {
            enrollStudent(request, response);
            activeTab = "enrollStudent";
        } else {
            request.setAttribute("error", "Invalid action.");
        }

        request.setAttribute("activeTab", activeTab);
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String type = request.getParameter("type");

        try {
            String message = adminService.createUser(username, password, type);
            request.setAttribute("message", message);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while creating the user.");
        }
    }

    private void createCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseName = request.getParameter("courseName");
        String instructorUsername = request.getParameter("instructorUsername");

        try {
            String message = adminService.createCourse(courseName, instructorUsername);
            request.setAttribute("message", message);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while creating the course.");
        }
    }

    private void enrollStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentUsername = request.getParameter("studentUsername");
        String courseName = request.getParameter("courseName");

        try {
            String message = adminService.enrollStudentInTheCourse(studentUsername, courseName);
            request.setAttribute("message", message);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while enrolling the student.");
        }
    }
}
