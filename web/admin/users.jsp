<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .sidebar {
                min-height: 100vh;
                background: #343a40;
                color: #fff;
            }
            .sidebar .nav-link {
                color: rgba(255,255,255,.75);
            }
            .sidebar .nav-link:hover {
                color: #fff;
            }
            .sidebar .nav-link.active {
                color: #fff;
                background: rgba(255,255,255,.1);
            }
            .main-content {
                padding: 20px;
            }
            .actions {
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2 d-none d-md-block sidebar px-0">
                    <div class="py-3 px-3 mb-3 text-center">
                        <h4>Admin Panel</h4>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="admin">
                                <i class="fas fa-tachometer-alt mr-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="user-management">
                                <i class="fas fa-users mr-2"></i>Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="manager">
                                <i class="fas fa-box mr-2"></i>Products
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="home">
                                <i class="fas fa-home mr-2"></i>Back to Shop
                            </a>
                        </li>
                    </ul>
                </div>
                
                <!-- Main content -->
                <div class="col-md-10 ml-sm-auto main-content">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">User Management</h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <div class="btn-group mr-2">
                                <a href="user-management?action=add" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-plus"></i> Add New User
                                </a>
                                <a href="admin" class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Users table -->
                    <div class="card">
                        <div class="card-header">
                            <h5>Users List</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
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
                                        <c:forEach items="${accounts}" var="a">
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
                                                    <a href="user-management?action=edit&id=${a.id}" class="btn btn-sm btn-info">
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
                    </div>
                </div>
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
        
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        
        <script>
            function confirmDelete(id) {
                document.getElementById('deleteLink').href = 'user-management?action=delete&id=' + id;
                $('#deleteModal').modal('show');
            }
        </script>
    </body>
</html> 