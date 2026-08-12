package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.Marks;
import com.sms.util.DBConnection;

public class MarksDAO {

    private int calculateTotal(Marks m) {
        return m.getInternal1() + m.getInternal2() + m.getAssignment() + m.getFinalExam();
    }

    private String calculateGrade(int total) {
        if (total >= 90) return "S";
        if (total >= 80) return "A";
        if (total >= 70) return "B";
        if (total >= 60) return "C";
        if (total >= 50) return "D";
        if (total >= 40) return "E";
        return "F";
    }

    public boolean addMarks(Marks marks) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "INSERT INTO marks (student_id, course_id, internal1, internal2, assignment, final_exam, total, grade) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setInt(1, marks.getStudentId());
            ps.setInt(2, marks.getCourseId());
            ps.setInt(3, marks.getInternal1());
            ps.setInt(4, marks.getInternal2());
            ps.setInt(5, marks.getAssignment());
            ps.setInt(6, marks.getFinalExam());
            
            int total = calculateTotal(marks);
            String grade = calculateGrade(total);
            ps.setInt(7, total);
            ps.setString(8, grade);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public ArrayList<Marks> getAllMarks() {
        ArrayList<Marks> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT m.*, s.full_name AS student_name, c.course_code, c.course_name " +
                           "FROM marks m " +
                           "JOIN student s ON m.student_id = s.student_id " +
                           "JOIN course c ON m.course_id = c.course_id";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Marks m = new Marks();
                m.setMarksId(rs.getInt("marks_id"));
                m.setStudentId(rs.getInt("student_id"));
                m.setStudentName(rs.getString("student_name"));
                m.setCourseId(rs.getInt("course_id"));
                m.setCourseCode(rs.getString("course_code"));
                m.setCourseName(rs.getString("course_name"));
                m.setInternal1(rs.getInt("internal1"));
                m.setInternal2(rs.getInt("internal2"));
                m.setAssignment(rs.getInt("assignment"));
                m.setFinalExam(rs.getInt("final_exam"));
                m.setTotal(rs.getInt("total"));
                m.setGrade(rs.getString("grade"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    public Marks getMarksById(int marksId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT m.*, s.full_name AS student_name, c.course_code, c.course_name " +
                           "FROM marks m " +
                           "JOIN student s ON m.student_id = s.student_id " +
                           "JOIN course c ON m.course_id = c.course_id " +
                           "WHERE m.marks_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, marksId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Marks m = new Marks();
                m.setMarksId(rs.getInt("marks_id"));
                m.setStudentId(rs.getInt("student_id"));
                m.setStudentName(rs.getString("student_name"));
                m.setCourseId(rs.getInt("course_id"));
                m.setCourseCode(rs.getString("course_code"));
                m.setCourseName(rs.getString("course_name"));
                m.setInternal1(rs.getInt("internal1"));
                m.setInternal2(rs.getInt("internal2"));
                m.setAssignment(rs.getInt("assignment"));
                m.setFinalExam(rs.getInt("final_exam"));
                m.setTotal(rs.getInt("total"));
                m.setGrade(rs.getString("grade"));
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    public ArrayList<Marks> getMarksByStudentId(int studentId) {
        ArrayList<Marks> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT m.*, s.full_name AS student_name, c.course_code, c.course_name " +
                           "FROM marks m " +
                           "JOIN student s ON m.student_id = s.student_id " +
                           "JOIN course c ON m.course_id = c.course_id " +
                           "WHERE m.student_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Marks m = new Marks();
                m.setMarksId(rs.getInt("marks_id"));
                m.setStudentId(rs.getInt("student_id"));
                m.setStudentName(rs.getString("student_name"));
                m.setCourseId(rs.getInt("course_id"));
                m.setCourseCode(rs.getString("course_code"));
                m.setCourseName(rs.getString("course_name"));
                m.setInternal1(rs.getInt("internal1"));
                m.setInternal2(rs.getInt("internal2"));
                m.setAssignment(rs.getInt("assignment"));
                m.setFinalExam(rs.getInt("final_exam"));
                m.setTotal(rs.getInt("total"));
                m.setGrade(rs.getString("grade"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    public boolean updateMarks(Marks marks) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE marks SET student_id = ?, course_id = ?, internal1 = ?, internal2 = ?, assignment = ?, final_exam = ?, total = ?, grade = ? WHERE marks_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, marks.getStudentId());
            ps.setInt(2, marks.getCourseId());
            ps.setInt(3, marks.getInternal1());
            ps.setInt(4, marks.getInternal2());
            ps.setInt(5, marks.getAssignment());
            ps.setInt(6, marks.getFinalExam());

            int total = calculateTotal(marks);
            String grade = calculateGrade(total);
            ps.setInt(7, total);
            ps.setString(8, grade);
            ps.setInt(9, marks.getMarksId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean deleteMarks(int marksId) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "DELETE FROM marks WHERE marks_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, marksId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
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
