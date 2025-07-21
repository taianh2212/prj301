package control;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import constants.Constants;
import dao.DAO;
import entity.Account;
import entity.GoogleUser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@WebServlet(name = "GoogleCallbackControl", urlPatterns = {"/google-callback"})
public class GoogleCallbackControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Get authorization code and state from callback
            String code = request.getParameter("code");
            String state = request.getParameter("state");
            
            // Check if code is present
            if (code == null || code.isEmpty()) {
                request.setAttribute("error", "Không nhận được mã xác thực từ Google.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }
            
            // Verify state parameter to prevent CSRF attacks
            HttpSession session = request.getSession();
            String storedState = (String) session.getAttribute("google_state");
            if (storedState == null || !storedState.equals(state)) {
                request.setAttribute("error", "Phiên đăng nhập không hợp lệ. Vui lòng thử lại.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }
            
            // Exchange authorization code for access token
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                    new NetHttpTransport(),
                    JacksonFactory.getDefaultInstance(),
                    Constants.GOOGLE_TOKEN_URI,
                    Constants.GOOGLE_CLIENT_ID,
                    Constants.GOOGLE_CLIENT_SECRET,
                    code,
                    Constants.GOOGLE_REDIRECT_URI)
                    .execute();
            
            String accessToken = tokenResponse.getAccessToken();
            
            // Get user info using access token
            GoogleUser googleUser = getUserInfo(accessToken);
            
            if (googleUser != null) {
                // Check if user exists in our database
                DAO dao = new DAO();
                Account account = dao.checkGoogleAccountExist(googleUser.getEmail());
                
                if (account == null) {
                    // If user doesn't exist, create a new account
                    account = dao.insertGoogleAccount(googleUser.getEmail(), googleUser.getName());
                }
                
                if (account != null) {
                    // Set user in session
                    session.setAttribute("acc", account);
                    
                    // Redirect to home page
                    response.sendRedirect("home");
                } else {
                    request.setAttribute("error", "Không thể đăng nhập với tài khoản Google. Vui lòng thử lại sau.");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Không thể lấy thông tin từ Google. Vui lòng thử lại sau.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý đăng nhập Google: " + e.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    private GoogleUser getUserInfo(String accessToken) {
        try {
            String userInfoUrl = Constants.GOOGLE_USER_INFO_URI + "?access_token=" + accessToken;
            
            URL url = new URL(userInfoUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuffer content = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                }
                in.close();
                
                // Parse JSON response
                JSONParser parser = new JSONParser();
                JSONObject jsonObject = (JSONObject) parser.parse(content.toString());
                
                GoogleUser user = new GoogleUser();
                user.setId((String) jsonObject.get("id"));
                user.setEmail((String) jsonObject.get("email"));
                user.setName((String) jsonObject.get("name"));
                user.setGivenName((String) jsonObject.get("given_name"));
                user.setFamilyName((String) jsonObject.get("family_name"));
                user.setPictureUrl((String) jsonObject.get("picture"));
                user.setLocale((String) jsonObject.get("locale"));
                
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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
        return "Google Callback Servlet";
    }
} 