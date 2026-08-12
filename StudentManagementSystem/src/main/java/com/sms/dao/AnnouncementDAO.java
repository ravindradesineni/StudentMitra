package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.Announcement;
import com.sms.util.DBConnection;

public class AnnouncementDAO {

    public boolean addAnnouncement(Announcement announcement) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "INSERT INTO announcement (title, description, posted_date) VALUES (?, ?, CURRENT_TIMESTAMP)";
            ps = con.prepareStatement(query);
            ps.setString(1, announcement.getTitle());
            ps.setString(2, announcement.getDescription());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public ArrayList<Announcement> getAllAnnouncements() {
        ArrayList<Announcement> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM announcement ORDER BY posted_date DESC";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Announcement a = new Announcement();
                a.setAnnouncementId(rs.getInt("announcement_id"));
                a.setTitle(rs.getString("title"));
                a.setDescription(rs.getString("description"));
                a.setPostedDate(rs.getString("posted_date"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    public ArrayList<Announcement> getRecentAnnouncements(int limit) {
        ArrayList<Announcement> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM announcement ORDER BY posted_date DESC LIMIT ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                Announcement a = new Announcement();
                a.setAnnouncementId(rs.getInt("announcement_id"));
                a.setTitle(rs.getString("title"));
                a.setDescription(rs.getString("description"));
                a.setPostedDate(rs.getString("posted_date"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return list;
    }

    public Announcement getAnnouncementById(int id) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM announcement WHERE announcement_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Announcement a = new Announcement();
                a.setAnnouncementId(rs.getInt("announcement_id"));
                a.setTitle(rs.getString("title"));
                a.setDescription(rs.getString("description"));
                a.setPostedDate(rs.getString("posted_date"));
                return a;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    public boolean updateAnnouncement(Announcement announcement) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE announcement SET title = ?, description = ? WHERE announcement_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, announcement.getTitle());
            ps.setString(2, announcement.getDescription());
            ps.setInt(3, announcement.getAnnouncementId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean deleteAnnouncement(int id) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "DELETE FROM announcement WHERE announcement_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public int getTotalAnnouncements() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM announcement";
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
