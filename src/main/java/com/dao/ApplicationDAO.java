package com.dao;

import com.entity.Application;
import java.sql.*;
import java.util.*;

public class ApplicationDAO {
    
    // Method to get the total number of applications
    public static int getTotalApplications() {
        int totalApplications = 0;
        String query = "SELECT COUNT(*) FROM applications";

        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalApplications = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalApplications;
    }

    // Method to get the total number of pending applications
    public static int getTotalPendingApplications() {
        int totalPendingApplications = 0;
        String query = "SELECT COUNT(*) FROM applications WHERE status = 'Pending'";

        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalPendingApplications = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPendingApplications;
    }

    // Method to get the total number of accepted applications
    public static int getTotalAcceptedApplications() {
        int totalAcceptedApplications = 0;
        String query = "SELECT COUNT(*) FROM applications WHERE status = 'Accepted'";

        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalAcceptedApplications = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalAcceptedApplications;
    }

    // Method to get the total number of interview applications
    public static int getTotalRejectedApplications() {
        int totalRejectedApplications = 0;
        String query = "SELECT COUNT(*) FROM applications WHERE status = 'Rejected'";

        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
            	totalRejectedApplications = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRejectedApplications;
    }

    // Method to get all applications (with the status and other details)
    public static List<Application> getApplications() {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT * FROM applications";

        try (Connection conn = DBConnection.getConn();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Application application = new Application();
                application.setApplicationId(rs.getInt("application_id"));
                application.setJobId(rs.getInt("job_id"));
                application.setSeekerId(rs.getInt("seeker_id"));
                application.setStatus(rs.getString("status"));
                application.setAppliedAt(rs.getTimestamp("applied_at"));
                application.setEmail(rs.getString("email"));

                applications.add(application);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applications;
    }
}
