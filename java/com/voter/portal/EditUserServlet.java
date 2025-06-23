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
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,   // 1MB
    maxFileSize = 1024 * 1024 * 10,        // 10MB
    maxRequestSize = 1024 * 1024 * 15      // 15MB
)
public class EditUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("adminDashboard.jsp");
            return;
        }
        int id = Integer.parseInt(idParam);

        
        String gender = request.getParameter("gender");
        int age = Integer.parseInt(request.getParameter("age"));
        String address = request.getParameter("address");
        boolean isApproved = request.getParameter("isApproved") != null;

        
        Part photoPart = request.getPart("photo");
        Part idProofPart = request.getPart("id_proof");

        
        String rootPath = System.getProperty("user.dir");
        String uploadPath = rootPath + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        
        String timestamp = String.valueOf(System.currentTimeMillis());
        String photoFileName = Paths.get(photoPart.getSubmittedFileName()).getFileName().toString();
        String idProofFileName = Paths.get(idProofPart.getSubmittedFileName()).getFileName().toString();

        String uniquePhotoName = "photo_" + id + "_" + timestamp + "_" + photoFileName;
        String uniqueIdProofName = "id_" + id + "_" + timestamp + "_" + idProofFileName;

        Path photoFullPath = Paths.get(uploadPath, uniquePhotoName);
        Path idProofFullPath = Paths.get(uploadPath, uniqueIdProofName);

        
        try (InputStream photoStream = photoPart.getInputStream();
             InputStream idProofStream = idProofPart.getInputStream()) {

            Files.copy(photoStream, photoFullPath, StandardCopyOption.REPLACE_EXISTING);
            Files.copy(idProofStream, idProofFullPath, StandardCopyOption.REPLACE_EXISTING);

            System.out.println("✅ Photo saved at: " + photoFullPath);
            System.out.println("✅ ID Proof saved at: " + idProofFullPath);

        } catch (IOException e) {
            e.printStackTrace();
            request.getSession().setAttribute("editSuccess", false);
            response.sendRedirect("adminDashboard");
            return;
        }

        
        String dbPhotoPath = UPLOAD_DIR + "/" + uniquePhotoName;
        String dbIdProofPath = UPLOAD_DIR + "/" + uniqueIdProofName;


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

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("✅ User info updated in database for ID: " + id);
                request.getSession().setAttribute("editSuccess", true);
            } else {
                System.out.println("⚠️ No rows updated for ID: " + id);
                request.getSession().setAttribute("editSuccess", false);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("editSuccess", false);
        }


        response.sendRedirect("adminDashboard");
    }
}
