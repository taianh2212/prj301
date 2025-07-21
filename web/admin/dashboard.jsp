<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
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
            .success {
                background: #28a745;
                color: #fff;
            }
            .info {
                background: #17a2b8;
                color: #fff;
            }
            .main-content {
                padding: 20px;
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
                            <a class="nav-link active" href="admin">
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
                            <a class="nav-link" href="home">
                                <i class="fas fa-home mr-2"></i>Back to Shop
                            </a>
                        </li>
                    </ul>
                </div>
                
                <!-- Main content -->
                <div class="col-md-10 ml-sm-auto main-content">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Dashboard</h1>
                        <div class="btn-group">
                            <a href="home" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-home"></i> Home
                            </a>
                        </div>
                    </div>
                    
                    <!-- Stat cards -->
                    <div class="row">
                        <div class="col-md-3">
                            <div class="card-counter primary">
                                <i class="fas fa-users count-icon"></i>
                                <div class="count-title">Total Users</div>
                                <div class="count-number">${totalAccounts}</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card-counter danger">
                                <i class="fas fa-box count-icon"></i>
                                <div class="count-title">Total Products</div>
                                <div class="count-number">${totalProducts}</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card-counter success">
                                <i class="fas fa-tags count-icon"></i>
                                <div class="count-title">Categories</div>
                                <div class="count-number">${totalCategories}</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card-counter info">
                                <i class="fas fa-shopping-cart count-icon"></i>
                                <div class="count-title">Orders</div>
                                <div class="count-number">0</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent users table -->
                    <div class="card mt-4">
                        <div class="card-header d-flex justify-content-between">
                            <h5>Recent Users</h5>
                            <a href="user-management" class="btn btn-sm btn-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Role</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${accounts}" var="a" begin="0" end="4">
                                            <tr>
                                                <td>${a.id}</td>
                                                <td>${a.user}</td>
                                                <td>
                                                    <c:if test="${a.isAdmin == 1}">
                                                        <span class="badge badge-primary">Admin</span>
                                                    </c:if>
                                                    <c:if test="${a.isSell == 1}">
                                                        <span class="badge badge-success">Seller</span>
                                                    </c:if>
                                                    <c:if test="${a.isAdmin == 0 && a.isSell == 0}">
                                                        <span class="badge badge-secondary">User</span>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent products table -->
                    <div class="card mt-4">
                        <div class="card-header d-flex justify-content-between">
                            <h5>Recent Products</h5>
                            <a href="manager" class="btn btn-sm btn-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Image</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${products}" var="p" begin="0" end="4">
                                            <tr>
                                                <td>${p.id}</td>
                                                <td>
                                                    <img src="${p.image}" alt="${p.name}" style="width:50px; height:50px">
                                                </td>
                                                <td>${p.name}</td>
                                                <td>$${p.price}</td>
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
        
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html> 