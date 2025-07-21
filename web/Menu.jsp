<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--begin of menu-->
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="home"><i class="fas fa-music mr-2"></i>Music Store</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
            <ul class="navbar-nav m-auto">
                <c:if test="${sessionScope.acc.isAdmin == 1}">
                    <li class="nav-item">
                        <a class="nav-link" href="admin"><i class="fa fa-dashboard"></i> Admin Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user-management"><i class="fa fa-users"></i> User Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user"><i class="fa fa-user"></i> Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manager"><i class="fa fa-box"></i> Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin-manager"><i class="fa fa-cogs"></i> Complete Manager</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.acc.isSell == 1}">
                    <li class="nav-item">
                        <a class="nav-link" href="manager">Manager Product</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.acc != null}">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Hello ${sessionScope.acc.user}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">Logout</a>
                    </li> 
                </c:if>
                <c:if test="${sessionScope.acc == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="Login.jsp">Login</a>
                    </li>
                </c:if>
            </ul>

            <form action="search" method="post" class="form-inline my-2 my-lg-0">
                <div class="input-group input-group-sm">
                    <input oninput="searchByName(this)" value="${txtS}" name="txt" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary btn-number">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
                <a class="btn btn-success btn-sm ml-3" href="cart">
                    <i class="fa fa-shopping-cart"></i> Cart
                    <c:set var="cartSize" value="${sessionScope.cart != null ? sessionScope.cart.size() : 0}" />
                    <span class="badge badge-light">${cartSize}</span>
                </a>
            </form>
        </div>
    </div>
</nav>
<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading">Cửa hàng nhạc cụ chất lượng cao</h1>
        <p class="lead text-muted mb-0">Uy tín tạo nên thương hiệu với hơn 10 năm cung cấp các loại nhạc cụ từ các thương hiệu nổi tiếng</p>
    </div>
</section>
<!--end of menu-->
