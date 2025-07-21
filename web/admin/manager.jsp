<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Manager</title>
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
            .card-counter {
                box-shadow: 0 4px 8px rgba(0,0,0,.1);
                margin: 10px 0;
                padding: 20px;
                background: #fff;
                border-radius: 5px;
            }
            .card-counter .count-icon {
                font-size: 4rem;
                opacity: .3;
            }
            .card-counter .count-title {
                font-size: 1.2rem;
                font-weight: bold;
            }
            .card-counter .count-number {
                font-size: 2.5rem;
                font-weight: bold;
            }
            .primary {
                background: #007bff;
                color: #fff;
            }
            .danger {
                background: #dc3545;
                color: #fff;
            }
            .nav-tabs {
                margin-bottom: 20px;
            }
            .tab-content {
                background: #fff;
                padding: 20px;
                border-radius: 0 0 5px 5px;
                box-shadow: 0 0 10px rgba(0,0,0,.1);
            }
            .actions {
                white-space: nowrap;
            }
            .product-image {
                width: 50px;
                height: 50px;
                object-fit: cover;
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
                            <a class="nav-link" href="user-management">
                                <i class="fas fa-users mr-2"></i>Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="manager">
                                <i class="fas fa-box mr-2"></i>Products
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="admin-manager">
                                <i class="fas fa-cogs mr-2"></i>Complete Manager
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
                        <h1 class="h2">Admin Manager</h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <div class="btn-group mr-2">
                                <a href="home" class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-home"></i> Home
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Stats Row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-counter primary">
                                <i class="fas fa-users count-icon"></i>
                                <div class="count-title">Total Users</div>
                                <div class="count-number">${totalUsers}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-counter danger">
                                <i class="fas fa-box count-icon"></i>
                                <div class="count-title">Total Products</div>
                                <div class="count-number">${totalProducts}</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Tabs -->
                    <ul class="nav nav-tabs mt-4" id="managerTabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="users-tab" data-toggle="tab" href="#users" role="tab" aria-controls="users" aria-selected="true">
                                <i class="fas fa-users"></i> User Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="products-tab" data-toggle="tab" href="#products" role="tab" aria-controls="products" aria-selected="false">
                                <i class="fas fa-box"></i> Product Management
                            </a>
                        </li>
                    </ul>
                    
                    <div class="tab-content" id="managerTabContent">
                        <!-- Users Tab -->
                        <div class="tab-pane fade show active" id="users" role="tabpanel" aria-labelledby="users-tab">
                            <div class="d-flex justify-content-between mb-3">
                                <h4>User List</h4>
                                <a href="user-management?action=add" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add New User
                                </a>
                            </div>
                            
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
                                                    <a href="#" onclick="confirmDeleteUser(${a.id})" class="btn btn-sm btn-danger">
                                                        <i class="fas fa-trash"></i> Delete
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <!-- Products Tab -->
                        <div class="tab-pane fade" id="products" role="tabpanel" aria-labelledby="products-tab">
                            <div class="d-flex justify-content-between mb-3">
                                <h4>Product List</h4>
                                <a href="manager?action=add" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add New Product
                                </a>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Image</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${products}" var="p">
                                            <tr>
                                                <td>${p.id}</td>
                                                <td>
                                                    <img src="${p.image}" alt="${p.name}" class="product-image">
                                                </td>
                                                <td>${p.name}</td>
                                                <td>$${p.price}</td>
                                                <td class="actions">
                                                    <a href="loadProduct?pid=${p.id}" class="btn btn-sm btn-info">
                                                        <i class="fas fa-edit"></i> Edit
                                                    </a>
                                                    <a href="#" onclick="confirmDeleteProduct(${p.id})" class="btn btn-sm btn-danger">
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
        
        <!-- Delete User Modal -->
        <div class="modal fade" id="deleteUserModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this user?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a href="#" id="deleteUserLink" class="btn btn-danger">Delete</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Delete Product Modal -->
        <div class="modal fade" id="deleteProductModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this product?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a href="#" id="deleteProductLink" class="btn btn-danger">Delete</a>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        
        <script>
            function confirmDeleteUser(id) {
                document.getElementById('deleteUserLink').href = 'user-management?action=delete&id=' + id;
                $('#deleteUserModal').modal('show');
            }
            
            function confirmDeleteProduct(id) {
                document.getElementById('deleteProductLink').href = 'delete?pid=' + id;
                $('#deleteProductModal').modal('show');
            }
        </script>
    </body>
</html> 