package com.sms.dao;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.sms.model.Department;
import com.sms.util.DBConnection;

public class DepartmentDAO {

    // ================= ADD DEPARTMENT =================

    public boolean addDepartment(Department department) {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            String query = "INSERT INTO department (department_name) VALUES (?)";

            ps = con.prepareStatement(query);

            ps.setString(1, department.getDepartmentName());

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
 // ================= VIEW ALL DEPARTMENTS =================

    public ArrayList<Department> getAllDepartments() {

        ArrayList<Department> departmentList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM department";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {

                Department department = new Department();

                department.setDepartmentId(rs.getInt("department_id"));
                department.setDepartmentName(rs.getString("department_name"));

                departmentList.add(department);

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

        return departmentList;

    }
 // ================= GET DEPARTMENT BY ID =================

    public Department getDepartmentById(int departmentId) {

        Department department = null;

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT * FROM department WHERE department_id=?";

            ps = con.prepareStatement(query);

            ps.setInt(1, departmentId);

            rs = ps.executeQuery();

            if (rs.next()) {

                department = new Department();

                department.setDepartmentId(rs.getInt("department_id"));
                department.setDepartmentName(rs.getString("department_name"));

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

        return department;

    }
 // ================= UPDATE DEPARTMENT =================

    public boolean updateDepartment(Department department) {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            String query = "UPDATE department SET department_name=? WHERE department_id=?";

            ps = con.prepareStatement(query);

            ps.setString(1, department.getDepartmentName());
            ps.setInt(2, department.getDepartmentId());

            int rows = ps.executeUpdate();

            return rows > 0;

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
 // ================= DELETE DEPARTMENT =================

    public boolean deleteDepartment(int departmentId) {

        Connection con = null;
        PreparedStatement ps = null;

        try {

            con = DBConnection.getConnection();

            String query = "DELETE FROM department WHERE department_id=?";

            ps = con.prepareStatement(query);

            ps.setInt(1, departmentId);

            int rows = ps.executeUpdate();

            return rows > 0;

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
    public ArrayList<Department> getDepartmentSummary() {

        ArrayList<Department> departmentList = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT d.department_id, d.department_name, COUNT(s.student_id) AS totalStudents "
                         + "FROM department d "
                         + "LEFT JOIN student s ON d.department_name = s.department "
                         + "GROUP BY d.department_id, d.department_name";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {

                Department department = new Department();

                department.setDepartmentId(rs.getInt("department_id"));
                department.setDepartmentName(rs.getString("department_name"));

                // We will use this field to store the student count
                department.setTotalStudents(rs.getInt("totalStudents"));

                departmentList.add(department);
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

        return departmentList;
    }
    public int getTotalDepartments() {

        int count = 0;

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            con = DBConnection.getConnection();

            String query = "SELECT COUNT(*) FROM department";

            ps = con.prepareStatement(query);

            rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

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

        return count;
    }

}