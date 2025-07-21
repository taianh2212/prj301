package control;

import constants.Constants;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GoogleLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Generate a unique state parameter to prevent CSRF attacks
            String state = UUID.randomUUID().toString();
            
            // Store state in session for verification during callback
            HttpSession session = request.getSession();
            session.setAttribute("google_state", state);
            
            // Build the Google authorization URL
            String authURL = Constants.GOOGLE_AUTH_URI + "?" +
                    "client_id=" + Constants.GOOGLE_CLIENT_ID + 
                    "&redirect_uri=" + Constants.GOOGLE_REDIRECT_URI +
                    "&response_type=code" +
                    "&scope=" + Constants.GOOGLE_SCOPE +
                    "&state=" + state;
            
            // Redirect to Google's authentication page
            response.sendRedirect(authURL);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối đến Google. Vui lòng thử lại sau.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Google Login Servlet";
    }
} 