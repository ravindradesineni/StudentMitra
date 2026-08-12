package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.sms.model.Admin;
import com.sms.util.DBConnection;

public class AdminDAO {

    public boolean validateAdmin(String username, String password) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            // Get database connection
        	con = DBConnection.getConnection();

        	System.out.println("Connection Object = " + con);

        	if (con == null) {
        	    System.out.println("Connection is NULL");
        	    return false;
        	}

            // SQL Query
            String query = "SELECT * FROM admin WHERE username = ? AND password = ?";

            // Create PreparedStatement
            ps = con.prepareStatement(query);

            // Set values
            ps.setString(1, username);
            ps.setString(2, password);

            // Execute query
            rs = ps.executeQuery();

            // Check if admin exists
            if (rs.next()) {
                return true;
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

        return false;
        

    }
 // ================= CHECK USERNAME =================

    public boolean isUsernameExists(String username) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM admin WHERE username = ?";

            ps = con.prepareStatement(query);

            ps.setString(1, username);

            rs = ps.executeQuery();

            if (rs.next()) {

                return true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (Exception e) {

                e.printStackTrace();

            }

        }

        return false;

    }
 // ================= CHECK EMAIL =================

    public boolean isEmailExists(String email) {

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM admin WHERE email = ?";

            ps = con.prepareStatement(query);

            ps.setString(1, email);

            rs = ps.executeQuery();

            if (rs.next()) {

                return true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if (rs != null)
                    rs.close();

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (Exception e) {

                e.printStackTrace();

            }

        }

        return false;

    }
    public boolean addAdmin(Admin admin) {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            String query = "INSERT INTO admin(full_name, email, username, password) VALUES (?, ?, ?, ?)";

            ps = con.prepareStatement(query);

            ps.setString(1, admin.getFullName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, admin.getUsername());
            ps.setString(4, admin.getPassword());

            int rows = ps.executeUpdate();

            if (rows > 0) {

                return true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if (ps != null)
                    ps.close();

                if (con != null)
                    con.close();

            } catch (Exception e) {

                e.printStackTrace();

            }

        }

        return false;

    }

}