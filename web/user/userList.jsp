<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .table-container {
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .header {
                margin-bottom: 20px;
            }
            .actions {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../Menu.jsp"></jsp:include>
        
        <div class="container mt-4">
            <div class="row header">
                <div class="col-md-6">
                    <h2>User List</h2>
                </div>
                <div class="col-md-6 text-right">
                    <a href="user?action=create" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New User
                    </a>
                </div>
            </div>
            
            <div class="table-container">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Seller</th>
                            <th>Admin</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listAccounts}" var="a">
                            <tr>
                                <td>${a.id}</td>
                                <td>${a.user}</td>
                                <td>
                                    <c:if test="${a.isSell == 1}">
                                        <span class="badge badge-success">Yes</span>
                                    </c:if>
                                    <c:if test="${a.isSell == 0}">
                                        <span class="badge badge-secondary">No</span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${a.isAdmin == 1}">
                                        <span class="badge badge-primary">Yes</span>
                                    </c:if>
                                    <c:if test="${a.isAdmin == 0}">
                                        <span class="badge badge-secondary">No</span>
                                    </c:if>
                                </td>
                                <td class="actions">
                                    <a href="user?action=edit&id=${a.id}" class="btn btn-sm btn-info">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="#" onclick="confirmDelete(${a.id})" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete Confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this user?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a href="#" id="deleteLink" class="btn btn-danger">Delete</a>
                    </div>
                </div>
            </div>
        </div>
        
        <jsp:include page="../Footer.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        
        <script>
            function confirmDelete(id) {
                document.getElementById('deleteLink').href = 'user?action=delete&id=' + id;
                $('#deleteModal').modal('show');
            }
        </script>
    </body>
</html>
