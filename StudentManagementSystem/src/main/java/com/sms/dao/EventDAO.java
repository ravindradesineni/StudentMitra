package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.sms.model.Event;
import com.sms.util.DBConnection;

public class EventDAO {

    public boolean addEvent(Event event) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "INSERT INTO academic_calendar (title, event_type, event_date, event_time, description, status) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, event.getTitle());
            ps.setString(2, event.getEventType());
            ps.setDate(3, event.getEventDate());
            ps.setTime(4, event.getEventTime());
            ps.setString(5, event.getDescription());
            ps.setString(6, event.getStatus() != null ? event.getStatus() : "Upcoming");

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean updateEvent(Event event) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE academic_calendar SET title = ?, event_type = ?, event_date = ?, event_time = ?, description = ?, status = ? WHERE event_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, event.getTitle());
            ps.setString(2, event.getEventType());
            ps.setDate(3, event.getEventDate());
            ps.setTime(4, event.getEventTime());
            ps.setString(5, event.getDescription());
            ps.setString(6, event.getStatus());
            ps.setInt(7, event.getEventId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public boolean deleteEvent(int eventId) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            String query = "DELETE FROM academic_calendar WHERE event_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, eventId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }
        return false;
    }

    public Event getEventById(int eventId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM academic_calendar WHERE event_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, eventId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setEventType(rs.getString("event_type"));
                event.setEventDate(rs.getDate("event_date"));
                event.setEventTime(rs.getTime("event_time"));
                event.setDescription(rs.getString("description"));
                event.setStatus(rs.getString("status"));
                return event;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }
        return null;
    }

    public ArrayList<Event> getAllEvents(String search, String type, String sortOrder) {
        ArrayList<Event> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            StringBuilder query = new StringBuilder("SELECT * FROM academic_calendar WHERE 1=1");
            ArrayList<String> params = new ArrayList<>();

            if (search != null && !search.trim().isEmpty()) {
                query.append(" AND (title LIKE ? OR description LIKE ?)");
                params.add("%" + search.trim() + "%");
                params.add("%" + search.trim() + "%");
            }

            if (type != null && !type.trim().isEmpty() && !type.equalsIgnoreCase("All")) {
                query.append(" AND event_type = ?");
                params.add(type.trim());
            }

            if (sortOrder != null && sortOrder.equalsIgnoreCase("DESC")) {
                query.append(" ORDER BY event_date DESC");
            } else {
                query.append(" ORDER BY event_date ASC");
            }

            ps = con.prepareStatement(query.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("event_id"));
                event.setTitle(rs.getString("title"));
                event.setEventType(rs.getString("event_type"));
                event.setEventDate(rs.getDate("event_date"));
                event.setEventTime(rs.getTime("event_time"));
                event.setDescription(rs.getString("description"));
                event.setStatus(rs.getString("status"));
                list.add(event);
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
