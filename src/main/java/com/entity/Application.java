package com.entity;

import java.sql.Timestamp;

public class Application {
	
	private int applicationId;
    private int jobId;
    private int seekerId;
    private String status;
    private Timestamp appliedAt;
    private String email;

    public Application() {}

    public Application(int applicationId, int jobId, int seekerId, String status, Timestamp appliedAt, String email) {
        this.applicationId = applicationId;
        this.jobId = jobId;
        this.seekerId = seekerId;
        this.status = status;
        this.appliedAt = appliedAt;
        this.email=email;
    }

    // Getters & Setters
    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public int getSeekerId() { return seekerId; }
    public void setSeekerId(int seekerId) { this.seekerId = seekerId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    @Override
    public String toString() {
        return "Application [applicationId=" + applicationId + ", jobId=" + jobId + ", status=" + status + "]";
    }

}
