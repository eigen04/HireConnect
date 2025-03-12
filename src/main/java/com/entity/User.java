package com.entity;

import java.sql.Timestamp;
public class User {
	
	private int user_id;
	private String full_name;
	private String email;
	private String password;
	private String role;
	private String phone;
	private Timestamp created_at;
	
	public User() {}

	public User(int user_id, String full_name, String email, String password, String role, String phone,
			Timestamp created_at) {
		this.user_id = user_id;
		this.full_name = full_name;
		this.email = email;
		this.password = password;
		this.role = role;
		this.phone = phone;
		this.created_at = created_at;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getFull_name() {
		return full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	
	
	
}
