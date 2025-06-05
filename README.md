# 🗳️ Online Voter Registration Portal

A web-based voter registration system built with Java, JSP, Servlets, and MySQL. This application allows **Users** and **Administrators** to register, log in, and interact with a secure, role-based platform with enhanced UI and functionality.

---

## 🚀 Features

### 👥 User & Admin Management
- 🔐 User & Admin Registration & Login
- 🧭 Role-Based Redirection (Admin ➝ Dashboard | User ➝ Main Portal)
- 🛡️ Session Management and Access Protection

### 📊 Admin Dashboard
- 👤 View all registered users
- ✏️ Edit/Delete user records
- ⚙️ Full access to user management features

### ✅ Form Validation & UX
- ✅ HTML5 + JavaScript Validation (Enhanced)
- 🔄 Toast Notifications for actions (login success/failure, logout, etc.)
- 🔒 Secure login flow with session timeouts
- 🔐 Protected pages (no direct access via URL without session)

### 🎨 UI/UX Enhancements
- 🖼️ Added Logo and Favicon
- 🎨 Improved Color Scheme and Layout
- 🧱 Responsive design for mobile/tablet
- 📌 Consistent Header and Footer across pages
- 💬 Admin-only access message display
- 🧭 Breadcrumbs and Navigation Bar added
- ⏳ Page loading spinners and logout confirmation

### 🗃️ MySQL Database Integration
- All user data stored in MySQL securely
- Authentication via JDBC connection

---

## 🛠️ Tech Stack

- **Backend:** Java, Servlets, JSP  
- **Frontend:** HTML5, CSS, JavaScript  
- **Database:** MySQL  
- **Server:** Apache Tomcat  
- **IDE Recommended:** Eclipse / IntelliJ  

---

## 🧱 Database Schema


| Field      | Type      | Description               |
|------------|-----------|---------------------------|
| id         | INT (PK)  | Auto-increment ID         |
| name       | VARCHAR   | Full name                 |
| email      | VARCHAR   | Unique user email         |
| password   | VARCHAR   | User password (plain text, to be improved) |
| user_type  | VARCHAR   | ADMIN / USER              |

---

## 🔄 How to Run Locally

1. **Clone this repo**
   ```bash
   git clone https://github.com/your-username/online-voter-registration-portal.git

2. Import into Eclipse
  • As a Dynamic Web Project

3. Configure MySQL
  •Create a database voter_portal_db
  •Run the SQL script in /sql/init.sql (if available)

4. Update DBConnection.java
  String url = "jdbc:mysql://localhost:3306/voter_portal_db";
  String username = "root"; 
  String password = "your_password";

5. Add JDBC Driver
  •Download MySQL Connector/J
  •Right-click project → Build Path → Configure Build Path → Libraries → Add External JARs → select .jar file

6. Run on Tomcat Server
  • Right-click project → Run on Server
7. Access
   •Open main.jsp or login via login.jsp

✅ Future Improvements:
•🔐 Password encryption (e.g., BCrypt)
•📩 Email verification & OTP-based login
•🧾 Voter certificate generation (PDF)
•📱 Progressive Web App (PWA) version
•📈 Analytics in admin dashboard

🤝 Contributing
Feel free to fork, suggest improvements, or raise issues!
PRs are welcome 🚀

Made with 💻 and ☕ by Atharv Vats
