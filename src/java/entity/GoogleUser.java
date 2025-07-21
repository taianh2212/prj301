package entity;

public class GoogleUser {
    private String id;
    private String email;
    private String name;
    private String givenName;
    private String familyName;
    private String pictureUrl;
    private String locale;
    
    public GoogleUser() {
    }
    
    public GoogleUser(String id, String email, String name, String givenName, String familyName, String pictureUrl, String locale) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.givenName = givenName;
        this.familyName = familyName;
        this.pictureUrl = pictureUrl;
        this.locale = locale;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }
    
    @Override
    public String toString() {
        return "GoogleUser{" + "id=" + id + ", email=" + email + ", name=" + name + ", givenName=" + givenName + ", familyName=" + familyName + ", pictureUrl=" + pictureUrl + ", locale=" + locale + '}';
    }
} 