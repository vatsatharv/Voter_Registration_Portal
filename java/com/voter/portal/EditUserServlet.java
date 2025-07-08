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
            response.sendRedirect("adminDashboardServlet");
            return;
        }

        int id = Integer.parseInt(idParam);
        boolean isApproved = request.getParameter("isApproved") != null;

        // Get upload parts
        Part photoPart = request.getPart("photo");
        Part idProofPart = request.getPart("idProof");

        // Handle upload paths
        String rootPath = getServletContext().getRealPath(""); // Safer for deployment
        String uploadPath = rootPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String photoPathDB = null;
        String idProofPathDB = null;

        String timestamp = String.valueOf(System.currentTimeMillis());

        if (photoPart != null && photoPart.getSize() > 0) {
            String originalPhoto = Paths.get(photoPart.getSubmittedFileName()).getFileName().toString();
            String photoName = "photo_" + id + "_" + timestamp + "_" + originalPhoto;
            Path fullPhotoPath = Paths.get(uploadPath, photoName);

            try (InputStream is = photoPart.getInputStream()) {
                Files.copy(is, fullPhotoPath, StandardCopyOption.REPLACE_EXISTING);
                photoPathDB = UPLOAD_DIR + "/" + photoName;
                System.out.println("✅ Photo uploaded: " + photoPathDB);
            }
        }

        if (idProofPart != null && idProofPart.getSize() > 0) {
            String originalIdProof = Paths.get(idProofPart.getSubmittedFileName()).getFileName().toString();
            String idName = "id_" + id + "_" + timestamp + "_" + originalIdProof;
            Path fullIdPath = Paths.get(uploadPath, idName);

            try (InputStream is = idProofPart.getInputStream()) {
                Files.copy(is, fullIdPath, StandardCopyOption.REPLACE_EXISTING);
                idProofPathDB = UPLOAD_DIR + "/" + idName;
                System.out.println("✅ ID Proof uploaded: " + idProofPathDB);
            }
        }

        try (Connection conn = DBConnection.getConnection()) {

            StringBuilder sql = new StringBuilder("UPDATE users SET isApproved=?");
            if (photoPathDB != null) sql.append(", photo_path=?");
            if (idProofPathDB != null) sql.append(", id_proof_path=?");
            sql.append(" WHERE id=?");

            PreparedStatement ps = conn.prepareStatement(sql.toString());
            ps.setBoolean(1, isApproved);

            int paramIndex = 2;
            if (photoPathDB != null) ps.setString(paramIndex++, photoPathDB);
            if (idProofPathDB != null) ps.setString(paramIndex++, idProofPathDB);
            ps.setInt(paramIndex, id);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                request.getSession().setAttribute("editSuccess", true);
                System.out.println("✅ User updated in DB (id=" + id + ")");
            } else {
                request.getSession().setAttribute("editSuccess", false);
                System.out.println("⚠️ No rows updated for id=" + id);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("editSuccess", false);
        }

        response.sendRedirect("adminDashboardServlet");
    }
}
