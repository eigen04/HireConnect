package com.entity;

import java.sql.Timestamp;

public class Job {
	
	private int job_id;
	private int recruiter_id;
	private String title;
	private String description;
	private String location;
	private String category;
	private String salary_range;
	private String job_type;
	private Timestamp created_at;
	
	public Job() {}

	public Job(int job_id, int recruiter_id, String title, String description, String location, String category,
			String salary_range, String job_type, Timestamp created_at) {
		this.job_id = job_id;
		this.recruiter_id = recruiter_id;
		this.title = title;
		this.description = description;
		this.location = location;
		this.category = category;
		this.salary_range = salary_range;
		this.job_type = job_type;
		this.created_at = created_at;
	}

	public int getJob_id() {
		return job_id;
	}

	public void setJob_id(int job_id) {
		this.job_id = job_id;
	}

	public int getRecruiter_id() {
		return recruiter_id;
	}

	public void setRecruiter_id(int recruiter_id) {
		this.recruiter_id = recruiter_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSalary_range() {
		return salary_range;
	}

	public void setSalary_range(String salary_range) {
		this.salary_range = salary_range;
	}

	public String getJob_type() {
		return job_type;
	}

	public void setJob_type(String job_type) {
		this.job_type = job_type;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	
	
}
