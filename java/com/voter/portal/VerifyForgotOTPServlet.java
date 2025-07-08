package com.voter.portal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/verifyForgotOTP")
public class VerifyForgotOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp = request.getParameter("otp");

        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("forgotOtp");

        if (sessionOtp != null && sessionOtp.equals(enteredOtp)) {
            response.getWriter().write("OTP_VERIFIED");
        } else {
            response.getWriter().write("INVALID_OTP");
        }
    }
}
