# 🗳️ Online Voter Registration Portal

A web-based voter registration system built with Java, JSP, Servlets, and MySQL. The platform allows users and administrators to register, login, and interact with a secure, role-based interface. The project includes email-based OTP login, dynamic admin-controlled registration, and a user-friendly interface with AJAX-enhanced interactions.

---

## 🔖 Badges

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge\&logo=java\&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-blue?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge\&logo=mysql\&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Tomcat-F8DC75?style=for-the-badge\&logo=apachetomcat\&logoColor=black)
![Eclipse](https://img.shields.io/badge/Made%20with-Eclipse-1e1e1e.svg?style=for-the-badge\&logo=eclipse\&logoColor=white)

---

## 🚀 Features

### 👥 User & Admin Management

* Role-based login system (User/Admin)
* Secure session-based access control using OTP
* Admin dashboard with full user control (View, Edit, Delete)

### 📊 Admin Dashboard

* View all registered users
* Upload user photo & ID proof (with file renaming & path storage)
* Approve/reject users
* Only approved users can access the voting feature

### ✅ User Dashboard

* View eligibility status
* Vote Now button enabled only after admin approval
* Past results view after voting completed

### 🌟 Latest Enhancements

* ✉️ **OTP Authentication** via Gmail (AJAX-based)
* 🚀 AJAX-based login and registration
* 📷 Admin-only user registration page with file upload
* 📝 Unique filename generation using timestamps
* 🔒 Password change and reset functionality
* 🚑 Admin-only messages and control
* 🏡 Redirect after login based on role

### 🎨 UI/UX Enhancements

* 🖼️ Logo and favicon
* 🎨 Color scheme overhaul
* 🛏️ Responsive design for mobile/tablets
* ⚖️ Consistent header/footer layout
* 📘 Breadcrumb navigation
* 📋 Toast messages
* ⏳ Page spinners for feedback
* ❌ Logout confirmation popup

---

## 🔧 Tech Stack

* **Backend:** Java, Servlets, JSP
* **Frontend:** HTML5, CSS, JavaScript, AJAX
* **Database:** MySQL
* **Server:** Apache Tomcat
* **IDE Recommended:** Eclipse / IntelliJ

---

## 📁 Database Schema

### `users` Table

| Field       | Type     | Description                    |
| ----------- | -------- | ------------------------------ |
| id          | INT (PK) | Auto-increment ID              |
| name        | VARCHAR  | Full name                      |
| email       | VARCHAR  | Unique user email              |
| password    | VARCHAR  | User password                  |
| user\_type  | VARCHAR  | ADMIN / USER                   |
| gender      | VARCHAR  | Gender                         |
| age         | INT      | Age                            |
| address     | TEXT     | User address                   |
| photo\_path | VARCHAR  | Path to uploaded photo         |
| id\_path    | VARCHAR  | Path to uploaded ID proof      |
| isApproved  | BOOLEAN  | User approved or not (0 or 1)  |
| hasVoted    | BOOLEAN  | Whether user has already voted |

---

## 🔄 How to Run Locally

1. **Clone the repo**

   ```bash
   git clone https://github.com/your-username/online-voter-registration-portal.git
   ```

2. **Import into Eclipse**

   * As a Dynamic Web Project

3. **Configure MySQL**

   * Create a database `voter_portal_db`
   * Run the SQL script in `/sql/init.sql` *(if available)*

4. **Update `DBConnection.java`**

   ```java
   String url = "jdbc:mysql://localhost:3306/voter_portal_db";
   String username = "root";
   String password = "your_password";
   ```

5. **Add JDBC Driver**

   * Download MySQL Connector/J
   * Right-click project → Build Path → Configure Build Path → Libraries → Add External JARs

6. **Run on Tomcat Server**

   * Right-click project → Run on Server

7. **Access**

   * Open `main.jsp` to begin navigation

---

## 📈 Future Enhancements

* 🔐 Encrypt passwords with BCrypt
* 📧 Email verification and alerts
* 🌍 Deploy as PWA or Spring Boot version
* 📊 Admin analytics & graph charts
* 🔷 Voting history export/download

---

## 🤝 Contributing

Pull requests, suggestions, and issues are welcome. Fork it, improve it, and contribute back ✨

---

## 📌 Screenshots

| Login Page  | Admin Dashboard   | User Dashboard| New User Registration Page|
| ----------------------------------------------------------------------------------------  | -----------------------------------------| -------------------- | -------------------- |
| ![image](https://github.com/user-attachments/assets/ebfdba37-5b83-4b53-9c81-707e69e06a51) | ![image](https://github.com/user-attachments/assets/64e7875d-5361-4c11-8bcc-db80f731ae30) | ![image](https://github.com/user-attachments/assets/b3952389-3aa4-42c8-849b-e17005b817e8) | ![image](https://github.com/user-attachments/assets/f7062fac-f138-4aca-8750-e924663c7b09) |


---

## 🎥 Demo Video

User Workflow
https://github.com/user-attachments/assets/5fb6ec76-3aa0-4100-85e3-31cbf51e8411

Admin Workflow
https://github.com/user-attachments/assets/e67e2f12-9395-4cce-890c-1231f751a5a1

---

## 👋 Author

Made with dedication by **Atharv Vats**

---
