// RegisterUserServlet.java
package com.voter.portal;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/registerUser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024)
public class RegisterUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create upload directory if not exists
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));
        String address = request.getParameter("address");

        Part photoPart = request.getPart("photo");
        Part idProofPart = request.getPart("id_proof");

        String photoFileName = getUniqueFileName(photoPart);
        String idProofFileName = getUniqueFileName(idProofPart);

        String photoPath = UPLOAD_DIR + "/" + photoFileName;
        String idProofPath = UPLOAD_DIR + "/" + idProofFileName;

        Files.copy(photoPart.getInputStream(), Paths.get(uploadPath, photoFileName));
        Files.copy(idProofPart.getInputStream(), Paths.get(uploadPath, idProofFileName));

        try (Connection conn = DBConnection.getConnection()) {
        	String sql = "INSERT INTO users (name, email, password, user_type, gender, age, address, photo_path, id_proof_path) VALUES (?, ?, ?, 'USER', ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, gender);
            ps.setInt(5, age);
            ps.setString(6, address);
            ps.setString(7, photoPath);
            ps.setString(8, idProofPath);

            ps.executeUpdate();
            response.sendRedirect("adminDashboard?msg=User registered successfully.");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("adminUserRegister.jsp?error=" + e.getMessage());
        }
    }

    private String getUniqueFileName(Part part) {
        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String timeStamp = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
        return timeStamp + "_" + fileName;
    }
}
