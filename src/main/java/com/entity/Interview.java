package com.entity;

import java.security.Timestamp;

public class Interview {
	
	private int interviewId;
    private int applicationId;  
    private Timestamp interviewDate;
    private String interviewMode;  
    private String meetingLink; 
    private String status;

    public Interview() {}

    public Interview(int interviewId, int applicationId, Timestamp interviewDate, String interviewMode, String meetingLink, String status) {
        this.interviewId = interviewId;
        this.applicationId = applicationId;
        this.interviewDate = interviewDate;
        this.interviewMode = interviewMode;
        this.meetingLink = meetingLink;
        this.status = status;
    }

    // Getters & Setters
    public int getInterviewId() { return interviewId; }
    public void setInterviewId(int interviewId) { this.interviewId = interviewId; }

    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) { this.applicationId = applicationId; }

    public Timestamp getInterviewDate() { return interviewDate; }
    public void setInterviewDate(Timestamp interviewDate) { this.interviewDate = interviewDate; }

    public String getInterviewMode() { return interviewMode; }
    public void setInterviewMode(String interviewMode) { this.interviewMode = interviewMode; }

    public String getMeetingLink() { return meetingLink; }
    public void setMeetingLink(String meetingLink) { this.meetingLink = meetingLink; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Interview [interviewId=" + interviewId + ", applicationId=" + applicationId + 
               ", interviewDate=" + interviewDate + ", interviewMode=" + interviewMode + 
               ", meetingLink=" + meetingLink + ", status=" + status + "]";
    }

}
