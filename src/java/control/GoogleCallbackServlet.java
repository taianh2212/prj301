package control;

import constants.Constants;
import dao.DAO;
import entity.Account;
import entity.GoogleUser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GoogleCallbackServlet extends HttpServlet {

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
            
            // Get access token from Google using authorization code
            String accessToken = getAccessToken(code);
            
            if (accessToken != null) {
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
            } else {
                request.setAttribute("error", "Không thể xác thực với Google. Vui lòng thử lại sau.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý đăng nhập Google: " + e.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
    
    private String getAccessToken(String authCode) {
        try {
            // Set up connection to token URL
            URL url = new URL(Constants.GOOGLE_TOKEN_URI);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setDoOutput(true);

            // Build POST data
            String postData = "code=" + authCode
                    + "&client_id=" + Constants.GOOGLE_CLIENT_ID
                    + "&client_secret=" + Constants.GOOGLE_CLIENT_SECRET
                    + "&redirect_uri=" + Constants.GOOGLE_REDIRECT_URI
                    + "&grant_type=authorization_code";
            
            // Send data
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(postData.getBytes());
            outputStream.flush();
            outputStream.close();
            
            // Check response code
            int responseCode = connection.getResponseCode();
            if (responseCode != 200) {
                return null;
            }

            // Read response
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuilder responseBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                responseBuilder.append(line);
            }
            reader.close();
            String responseBody = responseBuilder.toString();
            
            // Extract access token using simple string manipulation
            if (responseBody.contains("\"access_token\":")) {
                int start = responseBody.indexOf("\"access_token\":\"") + 16;
                int end = responseBody.indexOf("\"", start);
                if (end > start) {
                    return responseBody.substring(start, end);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private GoogleUser getUserInfo(String accessToken) {
        try {
            // Set up connection to user info URL
            URL url = new URL(Constants.GOOGLE_USER_INFO_URI + "?access_token=" + accessToken);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            
            // Check response code
            int responseCode = connection.getResponseCode();
            if (responseCode != 200) {
                return null;
            }
            
            // Read response
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuilder responseBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                responseBuilder.append(line);
            }
            reader.close();
            String responseBody = responseBuilder.toString();
            
            // Create user object
            GoogleUser user = new GoogleUser();
            
            // Extract user data using simple string manipulation
            user.setId(extractJsonValue(responseBody, "id"));
            user.setEmail(extractJsonValue(responseBody, "email"));
            user.setName(extractJsonValue(responseBody, "name"));
            user.setGivenName(extractJsonValue(responseBody, "given_name"));
            user.setFamilyName(extractJsonValue(responseBody, "family_name"));
            user.setPictureUrl(extractJsonValue(responseBody, "picture"));
            user.setLocale(extractJsonValue(responseBody, "locale"));
            
            return user;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private String extractJsonValue(String json, String key) {
        try {
            String searchKey = "\"" + key + "\":\"";
            int start = json.indexOf(searchKey);
            if (start < 0) {
                searchKey = "\"" + key + "\":";
                start = json.indexOf(searchKey);
                if (start < 0) {
                    return "";
                }
                start += searchKey.length();
                // Handle numeric values
                int end = json.indexOf(",", start);
                if (end < 0) {
                    end = json.indexOf("}", start);
                }
                if (end < 0) {
                    return "";
                }
                return json.substring(start, end).trim();
            }
            
            start += searchKey.length();
            int end = json.indexOf("\"", start);
            if (end < 0) {
                return "";
            }
            return json.substring(start, end);
        } catch (Exception e) {
            return "";
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
        return "Google Callback Servlet";
    }
} 