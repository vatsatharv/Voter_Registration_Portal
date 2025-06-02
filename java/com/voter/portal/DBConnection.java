package com.voter.portal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load driver explicitly
        String url = "jdbc:mysql://localhost:3306/voter_portal_db?useSSL=false&serverTimezone=UTC";
        String username = "root";
        String password = "password";

        return DriverManager.getConnection(url, username, password);
    }
}
