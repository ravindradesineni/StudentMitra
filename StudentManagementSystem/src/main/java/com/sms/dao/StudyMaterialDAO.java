package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.StudyMaterial;
import com.sms.util.DBConnection;

public class StudyMaterialDAO {

    public boolean addMaterial(StudyMaterial material) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "INSERT INTO study_materials (course, semester, category, title, description, file_name, file_type, file_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, material.getCourse());
            ps.setString(2, material.getSemester());
            ps.setString(3, material.getCategory());
            ps.setString(4, material.getTitle());
            ps.setString(5, material.getDescription());
            ps.setString(6, material.getFileName());
            ps.setString(7, material.getFileType());
            ps.setString(8, material.getFilePath());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean updateMaterial(StudyMaterial material) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE study_materials SET course = ?, semester = ?, category = ?, title = ?, description = ?, file_name = ?, file_type = ?, file_path = ? WHERE material_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, material.getCourse());
            ps.setString(2, material.getSemester());
            ps.setString(3, material.getCategory());
            ps.setString(4, material.getTitle());
            ps.setString(5, material.getDescription());
            ps.setString(6, material.getFileName());
            ps.setString(7, material.getFileType());
            ps.setString(8, material.getFilePath());
            ps.setInt(9, material.getMaterialId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean deleteMaterial(int materialId) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "DELETE FROM study_materials WHERE material_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, materialId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public StudyMaterial getMaterialById(int materialId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM study_materials WHERE material_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, materialId);
            rs = ps.executeQuery();
            if (rs.next()) {
                StudyMaterial sm = new StudyMaterial();
                sm.setMaterialId(rs.getInt("material_id"));
                sm.setCourse(rs.getString("course"));
                sm.setSemester(rs.getString("semester"));
                sm.setCategory(rs.getString("category"));
                sm.setTitle(rs.getString("title"));
                sm.setDescription(rs.getString("description"));
                sm.setFileName(rs.getString("file_name"));
                sm.setFileType(rs.getString("file_type"));
                sm.setFilePath(rs.getString("file_path"));
                sm.setUploadedDate(rs.getTimestamp("uploaded_date"));
                return sm;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    public ArrayList<StudyMaterial> getAllMaterials(String search, String course, String semester, String category) {
        ArrayList<StudyMaterial> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            StringBuilder query = new StringBuilder("SELECT * FROM study_materials WHERE 1=1");
            ArrayList<String> params = new ArrayList<>();

            if (search != null && !search.trim().isEmpty()) {
                query.append(" AND (title LIKE ? OR description LIKE ? OR file_name LIKE ?)");
                String key = "%" + search.trim() + "%";
                params.add(key);
                params.add(key);
                params.add(key);
            }

            if (course != null && !course.trim().isEmpty() && !course.equalsIgnoreCase("All")) {
                query.append(" AND course = ?");
                params.add(course.trim());
            }

            if (semester != null && !semester.trim().isEmpty() && !semester.equalsIgnoreCase("All")) {
                query.append(" AND semester = ?");
                params.add(semester.trim());
            }

            if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
                query.append(" AND category = ?");
                params.add(category.trim());
            }

            query.append(" ORDER BY uploaded_date DESC");

            ps = con.prepareStatement(query.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                StudyMaterial sm = new StudyMaterial();
                sm.setMaterialId(rs.getInt("material_id"));
                sm.setCourse(rs.getString("course"));
                sm.setSemester(rs.getString("semester"));
                sm.setCategory(rs.getString("category"));
                sm.setTitle(rs.getString("title"));
                sm.setDescription(rs.getString("description"));
                sm.setFileName(rs.getString("file_name"));
                sm.setFileType(rs.getString("file_type"));
                sm.setFilePath(rs.getString("file_path"));
                sm.setUploadedDate(rs.getTimestamp("uploaded_date"));
                list.add(sm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
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
