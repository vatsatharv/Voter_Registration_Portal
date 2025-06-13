package com.voter.portal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Method to get all users from the DB
    public static List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, name, email, user_type FROM users";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setUserType(rs.getString("user_type"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }

    // ✅ Method to get user details by ID
    public static User getUserById(int id) {
        User user = null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setUserType(rs.getString("user_type"));
                user.setGender(rs.getString("gender"));
                user.setAge(rs.getInt("age"));
                user.setAddress(rs.getString("address"));
                user.setPhotoPath(rs.getString("photo_path"));
                user.setIdProofPath(rs.getString("id_proof_path"));
                user.setApproved(rs.getBoolean("isApproved"));
                user.setHasVoted(rs.getBoolean("hasVoted"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
