package com.voter.portal;

import java.util.List;

public class User {
    private int id;
    private String name;
    private String email;
    private String userType;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserType() {
        return userType;
    }
    public void setUserType(String userType) {
        this.userType = userType;
    }
	public static List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return null;
	}
}