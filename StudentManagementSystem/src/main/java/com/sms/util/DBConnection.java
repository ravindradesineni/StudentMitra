package com.sms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

//    private static final String URL = "jdbc:mysql://localhost:3306/student_management_system";
//    private static final String USERNAME = "root";
//    private static final String PASSWORD = "root";
    private static final String URL = System.getenv("DB_URL");
	private static final String USERNAME = System.getenv("DB_USERNAME");
	private static final String PASSWORD = System.getenv("DB_PASSWORD");

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("Driver Loaded Successfully!");

            Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            System.out.println("Database Connected Successfully!");

            return con;

        } catch (Exception e) {

            e.printStackTrace();
            return null;
        }
    }
}