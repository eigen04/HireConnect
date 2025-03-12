package com.dao;

import java.sql.*;
import java.util.*;
import com.entity.Job;

public class JobDAO {

    // Total Job Listings
    public static int getTotalJobListings() {
        int count = 0;
        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM jobs");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    // Fetch Job Listings
    public static List<Job> getJobListings() {
        List<Job> jobs = new ArrayList<>();
        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT job_id, recruiter_id, title, description, location, category, salary_range, job_type, created_at FROM jobs"
             );
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Job job = new Job();
                job.setJob_id(rs.getInt("job_id"));
                job.setRecruiter_id(rs.getInt("recruiter_id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setCategory(rs.getString("category"));
                job.setSalary_range(rs.getString("salary_range"));
                job.setJob_type(rs.getString("job_type"));
                job.setCreated_at(rs.getTimestamp("created_at"));
                jobs.add(job);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jobs;
    }
}
