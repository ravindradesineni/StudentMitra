package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.Assignment;
import com.sms.model.Submission;
import com.sms.util.DBConnection;

public class AssignmentDAO {

    // ================= ADD ASSIGNMENT =================
    public boolean addAssignment(Assignment assignment) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "INSERT INTO assignments (title, subject, description, due_date, pdf_path) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, assignment.getTitle());
            ps.setString(2, assignment.getSubject());
            ps.setString(3, assignment.getDescription());
            ps.setString(4, assignment.getDueDate());
            ps.setString(5, assignment.getPdfPath());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    // ================= GET ALL ASSIGNMENTS =================
    public ArrayList<Assignment> getAllAssignments() {
        ArrayList<Assignment> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM assignments ORDER BY due_date ASC";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Assignment a = new Assignment();
                a.setAssignmentId(rs.getInt("assignment_id"));
                a.setTitle(rs.getString("title"));
                a.setSubject(rs.getString("subject"));
                a.setDescription(rs.getString("description"));
                a.setDueDate(rs.getString("due_date"));
                a.setPdfPath(rs.getString("pdf_path"));
                a.setCreatedAt(rs.getString("created_at"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    // ================= GET ASSIGNMENT BY ID =================
    public Assignment getAssignmentById(int assignmentId) {
        Assignment a = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM assignments WHERE assignment_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, assignmentId);
            rs = ps.executeQuery();
            if (rs.next()) {
                a = new Assignment();
                a.setAssignmentId(rs.getInt("assignment_id"));
                a.setTitle(rs.getString("title"));
                a.setSubject(rs.getString("subject"));
                a.setDescription(rs.getString("description"));
                a.setDueDate(rs.getString("due_date"));
                a.setPdfPath(rs.getString("pdf_path"));
                a.setCreatedAt(rs.getString("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return a;
    }

    // ================= UPDATE ASSIGNMENT =================
    public boolean updateAssignment(Assignment assignment) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE assignments SET title = ?, subject = ?, description = ?, due_date = ?, pdf_path = ? WHERE assignment_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, assignment.getTitle());
            ps.setString(2, assignment.getSubject());
            ps.setString(3, assignment.getDescription());
            ps.setString(4, assignment.getDueDate());
            ps.setString(5, assignment.getPdfPath());
            ps.setInt(6, assignment.getAssignmentId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    // ================= DELETE ASSIGNMENT =================
    public boolean deleteAssignment(int assignmentId) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "DELETE FROM assignments WHERE assignment_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, assignmentId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    // ================= ADD SUBMISSION =================
    public boolean addSubmission(Submission submission) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            // Check if submission already exists for this student and assignment
            Submission existing = getSubmissionByStudentAndAssignment(submission.getStudentId(), submission.getAssignmentId());
            if (existing != null) {
                // If it exists, update it (re-submit)
                String query = "UPDATE submissions SET file_path = ?, file_name = ?, submission_date = CURRENT_TIMESTAMP, status = ? WHERE submission_id = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, submission.getFilePath());
                ps.setString(2, submission.getFileName());
                ps.setString(3, submission.getStatus());
                ps.setInt(4, existing.getSubmissionId());
                int rows = ps.executeUpdate();
                return rows > 0;
            } else {
                // Insert a new submission
                String query = "INSERT INTO submissions (assignment_id, student_id, file_path, file_name, status) VALUES (?, ?, ?, ?, ?)";
                ps = con.prepareStatement(query);
                ps.setInt(1, submission.getAssignmentId());
                ps.setInt(2, submission.getStudentId());
                ps.setString(3, submission.getFilePath());
                ps.setString(4, submission.getFileName());
                ps.setString(5, submission.getStatus());
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    // ================= GET SUBMISSION BY STUDENT & ASSIGNMENT =================
    public Submission getSubmissionByStudentAndAssignment(int studentId, int assignmentId) {
        Submission s = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM submissions WHERE student_id = ? AND assignment_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, studentId);
            ps.setInt(2, assignmentId);
            rs = ps.executeQuery();
            if (rs.next()) {
                s = new Submission();
                s.setSubmissionId(rs.getInt("submission_id"));
                s.setAssignmentId(rs.getInt("assignment_id"));
                s.setStudentId(rs.getInt("student_id"));
                s.setFilePath(rs.getString("file_path"));
                s.setFileName(rs.getString("file_name"));
                s.setSubmissionDate(rs.getString("submission_date"));
                s.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return s;
    }

    // ================= GET SUBMISSIONS BY STUDENT =================
    public ArrayList<Submission> getSubmissionsByStudent(int studentId) {
        ArrayList<Submission> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM submissions WHERE student_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Submission s = new Submission();
                s.setSubmissionId(rs.getInt("submission_id"));
                s.setAssignmentId(rs.getInt("assignment_id"));
                s.setStudentId(rs.getInt("student_id"));
                s.setFilePath(rs.getString("file_path"));
                s.setFileName(rs.getString("file_name"));
                s.setSubmissionDate(rs.getString("submission_date"));
                s.setStatus(rs.getString("status"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    // ================= GET SUBMISSIONS FOR ADMIN =================
    public ArrayList<Submission> getSubmissionsForAdmin(String search, String filterStatus, String sortBy) {
        ArrayList<Submission> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            StringBuilder query = new StringBuilder(
                "SELECT s.student_id, s.full_name AS student_name, s.email AS student_email, s.department, " +
                "a.assignment_id, a.title AS assignment_title, a.subject, a.due_date, " +
                "sub.submission_id, sub.file_path, sub.file_name, sub.submission_date, " +
                "sub.status AS submission_status, sub.marks, sub.feedback, sub.graded_on " +
                "FROM student s " +
                "CROSS JOIN assignments a " +
                "LEFT JOIN submissions sub ON s.student_id = sub.student_id AND a.assignment_id = sub.assignment_id " +
                "WHERE 1=1 "
            );

            if (filterStatus != null && !filterStatus.trim().isEmpty() && !filterStatus.equalsIgnoreCase("All")) {
                if (filterStatus.equalsIgnoreCase("Pending")) {
                    query.append("AND sub.submission_id IS NULL AND a.due_date >= CURDATE() ");
                } else if (filterStatus.equalsIgnoreCase("Expired")) {
                    query.append("AND sub.submission_id IS NULL AND a.due_date < CURDATE() ");
                } else {
                    query.append("AND sub.status = ? ");
                }
            }

            if (search != null && !search.trim().isEmpty()) {
                query.append("AND (s.full_name LIKE ? OR CAST(s.student_id AS CHAR) LIKE ? OR a.title LIKE ? OR s.department LIKE ?) ");
            }

            if (sortBy != null && !sortBy.trim().isEmpty()) {
                if (sortBy.equalsIgnoreCase("Submission Date")) {
                    query.append("ORDER BY COALESCE(sub.submission_date, '1970-01-01') DESC ");
                } else if (sortBy.equalsIgnoreCase("Due Date")) {
                    query.append("ORDER BY a.due_date ASC ");
                } else if (sortBy.equalsIgnoreCase("Student Name")) {
                    query.append("ORDER BY s.full_name ASC ");
                } else if (sortBy.equalsIgnoreCase("Assignment Title")) {
                    query.append("ORDER BY a.title ASC ");
                }
            } else {
                query.append("ORDER BY a.due_date ASC, s.full_name ASC ");
            }

            ps = con.prepareStatement(query.toString());
            int paramIndex = 1;

            if (filterStatus != null && !filterStatus.trim().isEmpty() && !filterStatus.equalsIgnoreCase("All") 
                && !filterStatus.equalsIgnoreCase("Pending") && !filterStatus.equalsIgnoreCase("Expired")) {
                ps.setString(paramIndex++, filterStatus);
            }

            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Submission sub = new Submission();
                sub.setStudentId(rs.getInt("student_id"));
                sub.setStudentName(rs.getString("student_name"));
                sub.setStudentEmail(rs.getString("student_email"));
                sub.setDepartment(rs.getString("department"));
                sub.setAssignmentId(rs.getInt("assignment_id"));
                sub.setAssignmentTitle(rs.getString("assignment_title"));
                sub.setSubject(rs.getString("subject"));
                sub.setDueDate(rs.getString("due_date"));
                
                int subId = rs.getInt("submission_id");
                if (rs.wasNull()) {
                    sub.setSubmissionId(0);
                    // Determine computed status for non-submitted assignments
                    java.sql.Date dDate = rs.getDate("due_date");
                    java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
                    if (dDate != null && today.after(dDate)) {
                        sub.setStatus("Expired");
                    } else {
                        sub.setStatus("Pending");
                    }
                } else {
                    sub.setSubmissionId(subId);
                    sub.setFilePath(rs.getString("file_path"));
                    sub.setFileName(rs.getString("file_name"));
                    sub.setSubmissionDate(rs.getString("submission_date"));
                    sub.setStatus(rs.getString("submission_status"));
                    int marksVal = rs.getInt("marks");
                    if (!rs.wasNull()) {
                        sub.setMarks(marksVal);
                    }
                    sub.setFeedback(rs.getString("feedback"));
                    sub.setGradedOn(rs.getString("graded_on"));
                }
                list.add(sub);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    // ================= GET SUBMISSION BY ID FOR ADMIN =================
    public Submission getSubmissionByIdForAdmin(int submissionId) {
        Submission sub = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = 
                "SELECT s.student_id, s.full_name AS student_name, s.email AS student_email, s.department, " +
                "a.assignment_id, a.title AS assignment_title, a.subject, a.due_date, " +
                "sub.submission_id, sub.file_path, sub.file_name, sub.submission_date, " +
                "sub.status AS submission_status, sub.marks, sub.feedback, sub.graded_on " +
                "FROM submissions sub " +
                "JOIN student s ON s.student_id = sub.student_id " +
                "JOIN assignments a ON a.assignment_id = sub.assignment_id " +
                "WHERE sub.submission_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, submissionId);
            rs = ps.executeQuery();
            if (rs.next()) {
                sub = new Submission();
                sub.setStudentId(rs.getInt("student_id"));
                sub.setStudentName(rs.getString("student_name"));
                sub.setStudentEmail(rs.getString("student_email"));
                sub.setDepartment(rs.getString("department"));
                sub.setAssignmentId(rs.getInt("assignment_id"));
                sub.setAssignmentTitle(rs.getString("assignment_title"));
                sub.setSubject(rs.getString("subject"));
                sub.setDueDate(rs.getString("due_date"));
                sub.setSubmissionId(rs.getInt("submission_id"));
                sub.setFilePath(rs.getString("file_path"));
                sub.setFileName(rs.getString("file_name"));
                sub.setSubmissionDate(rs.getString("submission_date"));
                sub.setStatus(rs.getString("submission_status"));
                int marksVal = rs.getInt("marks");
                if (!rs.wasNull()) {
                    sub.setMarks(marksVal);
                }
                sub.setFeedback(rs.getString("feedback"));
                sub.setGradedOn(rs.getString("graded_on"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return sub;
    }

    // ================= GRADE SUBMISSION =================
    public boolean gradeSubmission(int submissionId, int marks, String feedback) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE submissions SET marks = ?, feedback = ?, status = 'Graded', graded_on = CURRENT_TIMESTAMP WHERE submission_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, marks);
            ps.setString(2, feedback);
            ps.setInt(3, submissionId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    // Helper method to close resources safely
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
