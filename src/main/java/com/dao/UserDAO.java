package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.*;
import com.entity.User;

public class UserDAO {
	
	public static int getTotalUsers() {
		int count=0;
		try (Connection conn = DBConnection.getConn();
	             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users");
	             ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                count = rs.getInt(1);
	            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	public static int getTotalRecruiters() {
        int totalRecruiters = 0;
        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE role='recruiter'")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalRecruiters = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalRecruiters;
    }

    // New method to get count of job seekers
    public static int getTotalJobSeekers() {
        int totalJobSeekers = 0;
        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE role='job_seeker'")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalJobSeekers = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalJobSeekers;
    }
	public static List<User> getUserListings(){
		List<User> users = new ArrayList<>();
		try(Connection conn = DBConnection.getConn();
		PreparedStatement ps = conn.prepareStatement(
				"SELECT user_id, full_name, email, password, role, phone, created_at FROM users"
		);
		ResultSet rs = ps.executeQuery()){
			while (rs.next()) {
				User user = new User();
				user.setUser_id(rs.getInt("user_id"));
	            user.setFull_name(rs.getString("full_name"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            user.setRole(rs.getString("role"));
	            user.setPhone(rs.getString("phone"));
	            user.setCreated_at(rs.getTimestamp("created_at"));
	            users.add(user);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return users;
	}

}
