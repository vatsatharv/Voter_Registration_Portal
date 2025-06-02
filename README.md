# 🗳️ Online Voter Registration Portal

A web-based voter registration system built with **Java**, **JSP**, **Servlets**, and **MySQL**. The application allows users and administrators to register, login, and access role-based dashboards securely.

---

## 🚀 Features

- 🔐 **User & Admin Registration**
- 🔐 **Secure Login System**
- 🛡️ **Session Management & Protection**
- 🧭 **Role-Based Redirection (Admin/User)**
- ✅ **Form Validation (HTML5 + JS)**
- 🗃️ **MySQL Database Integration**

---

## 🛠️ Tech Stack

- **Backend:** Java, Servlets, JSP  
- **Frontend:** HTML5, CSS, JavaScript  
- **Database:** MySQL  
- **Server:** Apache Tomcat  
- **IDE Recommended:** Eclipse / IntelliJ

---

## 🧱 Database Schema

### `users` Table

| Field       | Type         | Description             |
|-------------|--------------|-------------------------|
| id          | INT (PK)     | Auto-increment ID       |
| name        | VARCHAR      | Full name               |
| email       | VARCHAR      | Unique user email       |
| password    | VARCHAR      | User password (plain, not recommended) |
| user_type   | VARCHAR      | ADMIN / USER            |

---

## 🔄 How to Run Locally

1. **Clone this repo**
    ```bash
    git clone https://github.com/your-username/online-voter-registration-portal.git
    ```

2. **Import into Eclipse** (as a Dynamic Web Project)

3. **Configure MySQL**
    - Create a database `voter_portal_db`
    - Run the SQL script in `/sql/init.sql` (if available)

4. **Update `DBConnection.java`**
    ```java
    String url = "jdbc:mysql://localhost:3306/voter_portal_db";
    String username = "root"; // your MySQL username
    String password = "your_password"; // your MySQL password
    ```

5. **Add JDBC Driver**
    - Download [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/)
    - Right-click project > Build Path > Configure Build Path > Libraries > Add External JARs > add the `.jar` file

6. **Run on Tomcat Server**

---

## ✅ Future Improvements

- 🔐 Password encryption (e.g., BCrypt)
- 📩 Email verification
- 📊 Admin dashboard with stats
- 📱 Responsive design

---



---

## 📄 License

MIT License – use it freely for learning and development.

---

## 🤝 Contributing

Feel free to fork, suggest improvements, or raise issues!

