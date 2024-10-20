package com.example.Controllers;

import com.example.DataBaseManager;
import com.example.dao.InstructorDAO;
import com.example.dao.InstructorDAOImplement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
@WebServlet("/instructor")
public class InstructorServlet extends HttpServlet {

    private InstructorDAO instructorDAO;

    @Override
    public void init() throws ServletException {
        try {
            DataBaseManager dbManager = new DataBaseManager();
            instructorDAO = new InstructorDAOImplement(dbManager.getConnection());
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize database connection.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String activeTab = request.getParameter("activeTab");
        try {

            ArrayList<String> courses = instructorDAO.showInstructorCourses(username);
            request.setAttribute("courses", courses);

            switch (action) {
                case "showStudents":
                    handleShowStudents(request, username);
                    activeTab = "showStudents";
                    break;
                case "submitGrade":
                    handleSubmitGrade(request);
                    activeTab = "enterGrades";
                    break;
            }

            request.setAttribute("activeTab", activeTab);
            request.getRequestDispatcher("instructor.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error processing instructor actions.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String usertype = (String) session.getAttribute("usertype");
        Boolean validUser = (Boolean) session.getAttribute("validUser");

        if (validUser != null && validUser && "Instructor".equalsIgnoreCase(usertype)) {
            try {
                ArrayList<String> courses = instructorDAO.showInstructorCourses(username);
                request.setAttribute("courses", courses);

                if (!courses.isEmpty()) {
                    String firstCourseName = courses.get(0);
                    ArrayList<String> students = instructorDAO.showStudentsInTheCourse(firstCourseName, username);
                    request.setAttribute("students", students);
                    request.setAttribute("selectedCourse", firstCourseName);
                }
                request.setAttribute("activeTab", "showCourses");
                request.getRequestDispatcher("instructor.jsp").forward(request, response);
            } catch (Exception e) {
                throw new ServletException("Error loading instructor dashboard.", e);
            }
        } else {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleShowStudents(HttpServletRequest request, String username) throws SQLException {
        String courseName = request.getParameter("courseName");
        ArrayList<String> students = instructorDAO.showStudentsInTheCourse(courseName, username);
        request.setAttribute("students", students);
        request.setAttribute("selectedCourse", courseName);

    }

    private void handleSubmitGrade(HttpServletRequest request) throws SQLException {
        String courseName = request.getParameter("courseName");
        String studentUsername = request.getParameter("studentUsername");
        int grade = Integer.parseInt(request.getParameter("grade"));

        try {
            String resultMessage = instructorDAO.enterStudentGrades(courseName, studentUsername, grade);
            request.setAttribute("statusMessage", "Grade submitted successfully!");
            request.setAttribute("statusType", "success");
        } catch (Exception e) {
            request.setAttribute("statusMessage", "Failed to submit grade. Please try again.");
            request.setAttribute("statusType", "failure");
        }
    }
}
