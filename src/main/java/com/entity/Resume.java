package com.entity;

public class Resume {
	private int seekerId;
    private int userId;
    private String resumePath;
    private String skills;
    private int experience;

    public Resume() {}

    public Resume(int seekerId, int userId, String resumePath, String skills, int experience) {
        this.seekerId = seekerId;
        this.userId = userId;
        this.resumePath = resumePath;
        this.skills = skills;
        this.experience = experience;
    }

    // Getters & Setters
    public int getSeekerId() { return seekerId; }
    public void setSeekerId(int seekerId) { this.seekerId = seekerId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getResumePath() { return resumePath; }
    public void setResumePath(String resumePath) { this.resumePath = resumePath; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public int getExperience() { return experience; }
    public void setExperience(int experience) { this.experience = experience; }

    @Override
    public String toString() {
        return "Resume [seekerId=" + seekerId + ", skills=" + skills + ", experience=" + experience + "]";
    }

}
