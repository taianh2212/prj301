package constants;

public class Constants {
    // Google OAuth 2.0 configuration
    public static final String GOOGLE_CLIENT_ID = "YOUR_CLIENT_ID";
    public static final String GOOGLE_CLIENT_SECRET = "YOUR_CLIENT_SECRET";
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:9999/google-callback";
    public static final String GOOGLE_AUTH_URI = "https://accounts.google.com/o/oauth2/auth";
    public static final String GOOGLE_TOKEN_URI = "https://oauth2.googleapis.com/token";
    public static final String GOOGLE_USER_INFO_URI = "https://www.googleapis.com/oauth2/v1/userinfo";
    
    // Scope for access to user's profile and email
    public static final String GOOGLE_SCOPE = "email profile";
} 