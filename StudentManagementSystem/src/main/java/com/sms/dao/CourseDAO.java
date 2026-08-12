package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.Course;
import com.sms.util.DBConnection;

public class CourseDAO {

    public boolean addCourse(Course course) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "INSERT INTO course (course_code, course_name, department, semester, faculty, credits) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, course.getCourseCode());
            ps.setString(2, course.getCourseName());
            ps.setString(3, course.getDepartment());
            ps.setString(4, course.getSemester());
            ps.setString(5, course.getFaculty());
            ps.setInt(6, course.getCredits());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public ArrayList<Course> getAllCourses() {
        ArrayList<Course> courseList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM course";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setDepartment(rs.getString("department"));
                course.setSemester(rs.getString("semester"));
                course.setFaculty(rs.getString("faculty"));
                course.setCredits(rs.getInt("credits"));
                courseList.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return courseList;
    }

    public Course getCourseById(int courseId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM course WHERE course_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, courseId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setDepartment(rs.getString("department"));
                course.setSemester(rs.getString("semester"));
                course.setFaculty(rs.getString("faculty"));
                course.setCredits(rs.getInt("credits"));
                return course;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    public boolean updateCourse(Course course) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE course SET course_code = ?, course_name = ?, department = ?, semester = ?, faculty = ?, credits = ? WHERE course_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, course.getCourseCode());
            ps.setString(2, course.getCourseName());
            ps.setString(3, course.getDepartment());
            ps.setString(4, course.getSemester());
            ps.setString(5, course.getFaculty());
            ps.setInt(6, course.getCredits());
            ps.setInt(7, course.getCourseId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean deleteCourse(int courseId) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "DELETE FROM course WHERE course_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, courseId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public int getTotalCourses() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM course";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return 0;
    }

    public ArrayList<Course> getCoursesByDepartment(String department) {
        ArrayList<Course> courseList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM course WHERE department = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, department);
            rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setDepartment(rs.getString("department"));
                course.setSemester(rs.getString("semester"));
                course.setFaculty(rs.getString("faculty"));
                course.setCredits(rs.getInt("credits"));
                courseList.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return courseList;
    }

    private void closeResources(Connection con, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
