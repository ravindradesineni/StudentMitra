package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.Attendance;
import com.sms.util.DBConnection;

public class AttendanceDAO {

    public boolean addAttendance(Attendance attendance) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "INSERT INTO attendance (student_id, course_id, total_classes, attended_classes, attendance_percentage) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setInt(1, attendance.getStudentId());
            ps.setInt(2, attendance.getCourseId());
            ps.setInt(3, attendance.getTotalClasses());
            ps.setInt(4, attendance.getAttendedClasses());
            
            double percentage = 0.0;
            if (attendance.getTotalClasses() > 0) {
                percentage = ((double) attendance.getAttendedClasses() / attendance.getTotalClasses()) * 100;
            }
            ps.setDouble(5, percentage);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public ArrayList<Attendance> getAllAttendance() {
        ArrayList<Attendance> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT a.*, s.full_name AS student_name, c.course_code, c.course_name " +
                           "FROM attendance a " +
                           "JOIN student s ON a.student_id = s.student_id " +
                           "JOIN course c ON a.course_id = c.course_id";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                att.setAttendanceId(rs.getInt("attendance_id"));
                att.setStudentId(rs.getInt("student_id"));
                att.setStudentName(rs.getString("student_name"));
                att.setCourseId(rs.getInt("course_id"));
                att.setCourseCode(rs.getString("course_code"));
                att.setCourseName(rs.getString("course_name"));
                att.setTotalClasses(rs.getInt("total_classes"));
                att.setAttendedClasses(rs.getInt("attended_classes"));
                att.setAttendancePercentage(rs.getDouble("attendance_percentage"));
                list.add(att);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    public Attendance getAttendanceById(int attendanceId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT a.*, s.full_name AS student_name, c.course_code, c.course_name " +
                           "FROM attendance a " +
                           "JOIN student s ON a.student_id = s.student_id " +
                           "JOIN course c ON a.course_id = c.course_id " +
                           "WHERE a.attendance_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, attendanceId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Attendance att = new Attendance();
                att.setAttendanceId(rs.getInt("attendance_id"));
                att.setStudentId(rs.getInt("student_id"));
                att.setStudentName(rs.getString("student_name"));
                att.setCourseId(rs.getInt("course_id"));
                att.setCourseCode(rs.getString("course_code"));
                att.setCourseName(rs.getString("course_name"));
                att.setTotalClasses(rs.getInt("total_classes"));
                att.setAttendedClasses(rs.getInt("attended_classes"));
                att.setAttendancePercentage(rs.getDouble("attendance_percentage"));
                return att;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    public ArrayList<Attendance> getAttendanceByStudentId(int studentId) {
        ArrayList<Attendance> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT a.*, s.full_name AS student_name, c.course_code, c.course_name " +
                           "FROM attendance a " +
                           "JOIN student s ON a.student_id = s.student_id " +
                           "JOIN course c ON a.course_id = c.course_id " +
                           "WHERE a.student_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();
                att.setAttendanceId(rs.getInt("attendance_id"));
                att.setStudentId(rs.getInt("student_id"));
                att.setStudentName(rs.getString("student_name"));
                att.setCourseId(rs.getInt("course_id"));
                att.setCourseCode(rs.getString("course_code"));
                att.setCourseName(rs.getString("course_name"));
                att.setTotalClasses(rs.getInt("total_classes"));
                att.setAttendedClasses(rs.getInt("attended_classes"));
                att.setAttendancePercentage(rs.getDouble("attendance_percentage"));
                list.add(att);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    public boolean updateAttendance(Attendance attendance) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE attendance SET student_id = ?, course_id = ?, total_classes = ?, attended_classes = ?, attendance_percentage = ? WHERE attendance_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, attendance.getStudentId());
            ps.setInt(2, attendance.getCourseId());
            ps.setInt(3, attendance.getTotalClasses());
            ps.setInt(4, attendance.getAttendedClasses());

            double percentage = 0.0;
            if (attendance.getTotalClasses() > 0) {
                percentage = ((double) attendance.getAttendedClasses() / attendance.getTotalClasses()) * 100;
            }
            ps.setDouble(5, percentage);
            ps.setInt(6, attendance.getAttendanceId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean deleteAttendance(int attendanceId) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "DELETE FROM attendance WHERE attendance_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, attendanceId);

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
