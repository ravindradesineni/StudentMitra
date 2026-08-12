package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.Student;
import com.sms.util.DBConnection;




public class StudentDAO {

    // ================= ADD STUDENT =================

    public boolean addStudent(Student student) {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            String query = "INSERT INTO student (full_name, email, phone, gender, dob, department, year, password, address, emergency_contact, profile_photo, course, semester, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(query);

            ps.setString(1, student.getFullName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPhone());
            ps.setString(4, student.getGender());
            ps.setString(5, student.getDob());
            ps.setString(6, student.getDepartment());
            ps.setInt(7, student.getYear());
            ps.setString(8, "Student@123");
            ps.setString(9, student.getAddress());
            ps.setString(10, student.getEmergencyContact());
            ps.setString(11, student.getProfilePhoto() != null ? student.getProfilePhoto() : "uploads/students/default-avatar.png");
            ps.setString(12, student.getCourse());
            ps.setString(13, student.getSemester());
            ps.setString(14, student.getStatus() != null ? student.getStatus() : "Active");

           

            int rows = ps.executeUpdate();

            if (rows > 0) {

                return true;

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return false;

    }

    // ================= VIEW ALL STUDENTS =================

    public ArrayList<Student> getAllStudents() {

        ArrayList<Student> studentList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM student";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setGender(rs.getString("gender"));
                student.setDob(rs.getString("dob"));
                student.setDepartment(rs.getString("department"));
                student.setYear(rs.getInt("year"));
                student.setPassword(rs.getString("password"));
                student.setAddress(rs.getString("address"));
                student.setEmergencyContact(rs.getString("emergency_contact"));
                student.setProfilePhoto(rs.getString("profile_photo"));
                student.setCourse(rs.getString("course"));
                student.setSemester(rs.getString("semester"));
                student.setStatus(rs.getString("status"));

                studentList.add(student);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return studentList;

    }
 // ================= RECENT STUDENTS =================

    public ArrayList<Student> getRecentStudents() {

        ArrayList<Student> studentList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM student ORDER BY student_id DESC LIMIT 5";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setDepartment(rs.getString("department"));
                student.setYear(rs.getInt("year"));

                studentList.add(student);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return studentList;

    }
 // ================= SEARCH STUDENTS =================

    public ArrayList<Student> searchStudents(String keyword) {

        ArrayList<Student> studentList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM student WHERE student_id LIKE ? OR full_name LIKE ? OR email LIKE ?";

            ps = con.prepareStatement(query);

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");

            rs = ps.executeQuery();

            while (rs.next()) {

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setGender(rs.getString("gender"));
                student.setDob(rs.getString("dob"));
                student.setDepartment(rs.getString("department"));
                student.setYear(rs.getInt("year"));
                student.setPassword(rs.getString("password"));
                student.setAddress(rs.getString("address"));
                student.setEmergencyContact(rs.getString("emergency_contact"));
                student.setProfilePhoto(rs.getString("profile_photo"));
                student.setCourse(rs.getString("course"));
                student.setSemester(rs.getString("semester"));
                student.setStatus(rs.getString("status"));

                studentList.add(student);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return studentList;

    }
 // ================= TOTAL STUDENTS =================

    public int getTotalStudents() {

        int total = 0;

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT COUNT(*) FROM student";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            if (rs.next()) {

                total = rs.getInt(1);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return total;

    }
 // ================= GET STUDENT BY ID =================

    public Student getStudentById(int studentId) {

        Student student = null;

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM student WHERE student_id = ?";

            ps = con.prepareStatement(query);

            ps.setInt(1, studentId);

            rs = ps.executeQuery();

            if (rs.next()) {

                student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setGender(rs.getString("gender"));
                student.setDob(rs.getString("dob"));
                student.setDepartment(rs.getString("department"));
                student.setYear(rs.getInt("year"));
                student.setPassword(rs.getString("password"));
                student.setAddress(rs.getString("address"));
                student.setEmergencyContact(rs.getString("emergency_contact"));
                student.setProfilePhoto(rs.getString("profile_photo"));
                student.setCourse(rs.getString("course"));
                student.setSemester(rs.getString("semester"));
                student.setStatus(rs.getString("status"));

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return student;

    }
 // ================= UPDATE STUDENT =================

    public boolean updateStudent(Student student) {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            String query = "UPDATE student SET full_name=?, email=?, phone=?, gender=?, dob=?, department=?, year=?, password=?, address=?, emergency_contact=?, profile_photo=?, course=?, semester=?, status=? WHERE student_id=?";

            ps = con.prepareStatement(query);

            ps.setString(1, student.getFullName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPhone());
            ps.setString(4, student.getGender());
            ps.setString(5, student.getDob());
            ps.setString(6, student.getDepartment());
            ps.setInt(7, student.getYear());
            ps.setString(8, student.getPassword());
            ps.setString(9, student.getAddress());
            ps.setString(10, student.getEmergencyContact());
            ps.setString(11, student.getProfilePhoto());
            ps.setString(12, student.getCourse());
            ps.setString(13, student.getSemester());
            ps.setString(14, student.getStatus());
            ps.setInt(15, student.getStudentId());

            int rows = ps.executeUpdate();

            if (rows > 0) {

                return true;

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return false;

    }
 // ================= STUDENT LOGIN =================

    public Student validateStudent(int studentId, String password) {

        Student student = null;

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM student WHERE student_id=? AND password=?";

            ps = con.prepareStatement(query);

            ps.setInt(1, studentId);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {

                student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setGender(rs.getString("gender"));
                student.setDob(rs.getString("dob"));
                student.setDepartment(rs.getString("department"));
                student.setYear(rs.getInt("year"));
                student.setPassword(rs.getString("password"));
                student.setAddress(rs.getString("address"));
                student.setEmergencyContact(rs.getString("emergency_contact"));
                student.setProfilePhoto(rs.getString("profile_photo"));
                student.setCourse(rs.getString("course"));
                student.setSemester(rs.getString("semester"));
                student.setStatus(rs.getString("status"));

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return student;

    }
 // ================= DELETE STUDENT =================

    public boolean deleteStudent(int studentId) {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            String query = "DELETE FROM student WHERE student_id = ?";

            ps = con.prepareStatement(query);

            ps.setInt(1, studentId);

            int rows = ps.executeUpdate();

            if (rows > 0) {

                return true;

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return false;

    }
    
    public ArrayList<Student> getStudentSummary() {

        ArrayList<Student> studentList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT student_id, full_name, department FROM student";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setDepartment(rs.getString("department"));

                studentList.add(student);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }

        }

        return studentList;

    }
 // ================= ACTIVATE ACCOUNT =================

    public boolean activateAccount(int studentId,
                                   String defaultPassword,
                                   String newPassword) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String checkQuery =
            "SELECT * FROM student WHERE student_id=? AND password=?";

            ps = con.prepareStatement(checkQuery);

            ps.setInt(1, studentId);
            ps.setString(2, defaultPassword);

            rs = ps.executeQuery();

            if(rs.next()){

                rs.close();
                ps.close();

                String updateQuery =
                "UPDATE student SET password=? WHERE student_id=?";

                ps = con.prepareStatement(updateQuery);

                ps.setString(1, newPassword);
                ps.setInt(2, studentId);

                int rows = ps.executeUpdate();

                if(rows > 0){

                    return true;

                }

            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if(rs != null)
                    rs.close();

                if(ps != null)
                    ps.close();

                if(con != null)
                    con.close();

            } catch (Exception e) {

                e.printStackTrace();

            }

        }

        return false;

    }

    // ================= CHANGE PASSWORD =================
    public boolean changePassword(int studentId, String currentPassword, String newPassword) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String checkQuery = "SELECT * FROM student WHERE student_id=? AND password=?";
            ps = con.prepareStatement(checkQuery);
            ps.setInt(1, studentId);
            ps.setString(2, currentPassword);
            rs = ps.executeQuery();
            if (rs.next()) {
                rs.close();
                ps.close();
                String updateQuery = "UPDATE student SET password=? WHERE student_id=?";
                ps = con.prepareStatement(updateQuery);
                ps.setString(1, newPassword);
                ps.setInt(2, studentId);
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

}