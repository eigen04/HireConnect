🚀 HireConnect – Your Ultimate Job Recruitment Platform
HireConnect is a powerful and user-friendly job recruitment system designed to bridge the gap between job seekers, recruiters, and admins. It allows job seekers to search, apply, and track job applications, while recruiters can post jobs, manage applications, schedule interviews, and view candidate profiles. The admin panel enables management of users, job listings, and platform activities.

🌟 Features at a Glance
👨‍💻 Job Seekers
✔️ Create and update your profile
✔️ Upload, view, download, and delete resumes
✔️ Search for jobs by keyword and apply
✔️ Set job alerts for notifications
✔️ Track the status of job applications (Pending, Accepted, Rejected)
✔️ View upcoming interviews and join them online
✔️ Provide reviews for companies

🏢 Recruiters
✔️ View company reviews
✔️ Post and manage job listings
✔️ View resumes uploaded by job seekers
✔️ Schedule and manage interviews
✔️ View applications and take actions (Accept/Reject)
✔️ Post job alerts
✔️ Upgrade job postings to premium (via fake payment system)

🛠️ Admin Panel
✔️ Manage job seekers and recruiter profiles
✔️ Approve/reject job listings
✔️ Monitor all platform activities
✔️ Manage applications and job listings
✔️ Generate hiring trends report

🛠️ Tech Stack
Technology	Description
Frontend	HTML, CSS, JavaScript, JSP, Bootstrap
Backend	Servlet, JDBC
Database	MySQL
Server	Apache Tomcat
Tools	Eclipse, MySQL Workbench
⚙️ Installation & Setup
1️⃣ Clone the Repository

bash
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


📸 Screenshots📸 Screenshots
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
