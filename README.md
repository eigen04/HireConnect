🚀 HireConnect – Your Ultimate Job Recruitment Platform
HireConnect is a powerful and user-friendly job recruitment system designed to bridge the gap between job seekers and recruiters. It allows recruiters to post jobs, manage applications, and schedule interviews, while job seekers can search, apply, and track their applications seamlessly.

🌟 Features at a Glance
👨‍💻 Job Seekers
✔️ Create a profile and upload resumes
✔️ Search and apply for jobs with advanced filters
✔️ Track application statuses in real-time
✔️ Get job alerts and view company reviews

🏢 Recruiters
✔️ Post and manage job listings
✔️ View, shortlist, and manage applications
✔️ Schedule interviews and provide feedback
✔️ Upgrade job postings (Fake Payment System)

🛠️ Admin Panel
✔️ Manage job seekers & recruiters
✔️ Approve/reject job listings
✔️ Monitor all platform activities

🛠️ Tech Stack
Technology	Description
Frontend	HTML, CSS, JavaScript, JSP, Bootstrap
Backend	Servlet, JDBC
Database	MySQL
Server	Apache Tomcat
Tools	Eclipse, MySQL Workbench
📁 Project Structure
swift
Copy
Edit
HireConnect/
│── src/
│   ├── main/java/com/admin/servlet/
│   │   ├── AdminDeleteApplicationServlet.java
│   │   ├── AdminDeleteJobServlet.java
│   │   ├── AdminDeleteUserServlet.java
│   ├── main/java/com/dao/
│   │   ├── ApplicationDAO.java
│   │   ├── DBConnection.java
│   │   ├── JobDAO.java
│   │   ├── UserDAO.java
│   ├── main/java/com/entity/
│   │   ├── Application.java
│   │   ├── Interview.java
│   │   ├── Job.java
│   │   ├── Payment.java
│   │   ├── Resume.java
│   │   ├── User.java
│   ├── main/java/com/servlet/
│   │   ├── ApplicationServlet.java
│   │   ├── ApplyJobServlet.java
│   │   ├── CompanyReviewServlet.java
│   │   ├── DeleteJobServlet.java
│   │   ├── DownloadResumeServlet.java
│   │   ├── EditJobServlet.java
│   │   ├── InterviewServlet.java
│   │   ├── JobAlertsServlet.java
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── PostJobServlet.java
│   │   ├── ProfileServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── UpdateApplicationStatusServlet.java
│   │   ├── ViewInterviewDetailsServlet.java
│── webapp/
│   ├── admin/
│   │   ├── adminDashboard.jsp
│   │   ├── manageApplications.jsp
│   │   ├── manageJobs.jsp
│   │   ├── manageUsers.jsp
│   ├── jobseeker/
│   │   ├── company_reviews.jsp
│   │   ├── dashboard.jsp
│   │   ├── jobAlerts.jsp
│   │   ├── myApplications.jsp
│   │   ├── profile.jsp
│   │   ├── viewJobs.jsp
│   ├── recruiter/
│   │   ├── editJob.jsp
│   │   ├── interviewDetails.jsp
│   │   ├── postJob.jsp
│   │   ├── scheduleInterview.jsp
│   │   ├── viewApplications.jsp
│   ├── WEB-INF/
│   │   ├── index.jsp
│   │   ├── login.jsp
│   │   ├── register.jsp
│── resources/
│   ├── CSS/
│   │   ├── style.css
│   ├── images/
│   │   ├── img1.svg
│   │   ├── img2.png
│── config/
│   ├── web.xml
│── pom.xml
│── README.md
⚙️ Installation & Setup
1️⃣ Clone the Repository
sh
Copy
Edit
git clone https://github.com/your-username/HireConnect.git
cd HireConnect
2️⃣ Import the Project into Eclipse
Open Eclipse IDE
Click File → Import → Existing Maven Projects
Select the cloned project folder and click Finish
3️⃣ Set Up the Database
Create a MySQL Database named hireconnect
Import the provided SQL file
4️⃣ Configure DBConnection.java
Modify the database credentials:

java
Copy
Edit
private static final String URL = "jdbc:mysql://localhost:3306/hireconnect";
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";
5️⃣ Deploy on Apache Tomcat
Right-click the project → Run As → Run on Server
Select Apache Tomcat Server
📸 Screenshots
🔹 Home Page
![image](https://github.com/user-attachments/assets/f84112a5-6b4f-400b-8908-3b6cb0ac88c5)
🔹 Job Seeker Dashboard 
![image](https://github.com/user-attachments/assets/f3effaee-ff35-4a3d-8ee0-d7cf55681846)
🔹 Recruiter Job Posting
![image](https://github.com/user-attachments/assets/cdbf54ba-c607-4243-8a3e-ae20dd3c3514)
🔹 Admin Panel
![image](https://github.com/user-attachments/assets/c1926323-02dc-4e07-9226-39cd0cad96fb)
![image](https://github.com/user-attachments/assets/2f566c03-cddb-43a9-9d75-341ea4bdef62)


👨‍💻 Contributing
We welcome contributions! Follow these steps to contribute:

Fork the repository
Create a new branch (git checkout -b feature-name)
Commit your changes (git commit -m "Added feature XYZ")
Push to the branch (git push origin feature-name)
Open a Pull Request
📄 License
This project is open-source and available under the MIT License.

🚀 HireConnect – Connecting Talent with Opportunity!
