package com.voter.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/editUser")
@MultipartConfig
public class EditUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Read user ID from form
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("adminDashboard.jsp");
            return;
        }
        int id = Integer.parseInt(idParam);

        // ✅ Extract form fields
        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));
        String address = request.getParameter("address");
        boolean isApproved = request.getParameter("isApproved") != null;

        // ✅ Handle uploaded files
        Part photoPart = request.getPart("photo");
        Part idProofPart = request.getPart("id_proof");

        // Get real path to upload directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Get original file names and generate unique names
        String photoFileName = Paths.get(photoPart.getSubmittedFileName()).getFileName().toString();
        String idProofFileName = Paths.get(idProofPart.getSubmittedFileName()).getFileName().toString();

        String timestamp = String.valueOf(System.currentTimeMillis());
        String uniquePhotoName = "photo_" + id + "_" + timestamp + "_" + photoFileName;
        String uniqueIdProofName = "id_" + id + "_" + timestamp + "_" + idProofFileName;

        Path photoFullPath = Paths.get(uploadPath, uniquePhotoName);
        Path idProofFullPath = Paths.get(uploadPath, uniqueIdProofName);

        try (InputStream photoStream = photoPart.getInputStream();
             InputStream idProofStream = idProofPart.getInputStream()) {

            Files.copy(photoStream, photoFullPath, StandardCopyOption.REPLACE_EXISTING);
            Files.copy(idProofStream, idProofFullPath, StandardCopyOption.REPLACE_EXISTING);
        }

        // Relative paths to store in DB
        String dbPhotoPath = UPLOAD_DIR + "/" + uniquePhotoName;
        String dbIdProofPath = UPLOAD_DIR + "/" + uniqueIdProofName;

        // ✅ Update the user in database
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE users SET gender=?, age=?, address=?, photo_path=?, id_proof_path=?, isApproved=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, gender);
            ps.setInt(2, age);
            ps.setString(3, address);
            ps.setString(4, dbPhotoPath);
            ps.setString(5, dbIdProofPath);
            ps.setBoolean(6, isApproved);
            ps.setInt(7, id);
            ps.executeUpdate();

            // Optional: Set success message
            request.getSession().setAttribute("editSuccess", true);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("editSuccess", false);
        }

        // ✅ Redirect back to admin dashboard
        response.sendRedirect("adminDashboard");
    }
}
