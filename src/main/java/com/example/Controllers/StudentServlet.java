package com.example.Controllers;


import com.example.DataBaseManager;
import com.example.dao.StudentDAO;
import com.example.dao.StudentDAOImplement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        try {
            DataBaseManager dbManager = new DataBaseManager();
            Connection connection = dbManager.getConnection();
            studentDAO = new StudentDAOImplement(connection);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize database connection.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String usertype = (String) session.getAttribute("usertype");
        Boolean validUser = (Boolean) session.getAttribute("validUser");

        if (validUser != null && validUser && "Student".equalsIgnoreCase(usertype)) {
            request.getRequestDispatcher("student.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String option = request.getParameter("options");

        try {
            if ("showGrades".equalsIgnoreCase(option)) {
                ArrayList<String> studentGrades = studentDAO.showGrades(username);
                request.setAttribute("studentChoice", studentGrades);
                request.getRequestDispatcher("showGrades.jsp").forward(request, response);
            } else if ("showGPA".equalsIgnoreCase(option)) {
                String GPA = studentDAO.showGPA(username);
                request.setAttribute("showGPA", GPA);
                request.getRequestDispatcher("showGPA.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("student.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving data.", e);
        }
    }
}
