<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .form-container {
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin-top: 20px;
            }
            .header {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../Menu.jsp"></jsp:include>
        
        <div class="container mt-4">
            <div class="row header">
                <div class="col">
                    <h2>Edit User</h2>
                </div>
            </div>
            
            <div class="form-container">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <form action="user?action=update" method="post">
                    <input type="hidden" name="id" value="${user.id}">
                    
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" value="${user.user}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" value="${user.pass}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>User Roles:</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="isSell" name="isSell" value="1" ${user.isSell == 1 ? "checked" : ""}>
                            <label class="form-check-label" for="isSell">Seller</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="isAdmin" name="isAdmin" value="1" ${user.isAdmin == 1 ? "checked" : ""}>
                            <label class="form-check-label" for="isAdmin">Administrator</label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update User
                        </button>
                        <a href="user" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
        
        <jsp:include page="../Footer.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>
