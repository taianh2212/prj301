<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Shoes Shop - Trang chủ</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fa;
            }
            .card {
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                transition: transform 0.3s;
                margin-bottom: 20px;
                border-radius: 8px;
                overflow: hidden;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .card-img-top {
                height: 200px;
                object-fit: cover;
            }
            .card-title {
                font-weight: 500;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }
            .card-title a {
                color: #333;
                text-decoration: none;
            }
            .card-text {
                color: #6c757d;
                height: 40px;
            }
            .btn-danger {
                background-color: #ff4444;
                border-color: #ff4444;
            }
            .btn-success {
                background-color: #00C851;
                border-color: #00C851;
            }
            .section-title {
                position: relative;
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
            }
            .section-title::after {
                content: '';
                position: absolute;
                display: block;
                width: 80px;
                height: 3px;
                background: #ff4444;
                bottom: 0;
                left: calc(50% - 40px);
            }
            .carousel-item img {
                height: 500px;
                object-fit: cover;
            }
            .badge-offer {
                position: absolute;
                top: 10px;
                left: 10px;
                background-color: #ff4444;
                color: white;
                padding: 5px 10px;
                border-radius: 3px;
                font-size: 0.8rem;
                z-index: 10;
            }
            .product-rating {
                color: #ffc107;
                font-size: 0.8rem;
                margin-bottom: 8px;
            }
            .btn-load-more {
                background-color: #343a40;
                color: white;
                padding: 10px 30px;
                border-radius: 30px;
                font-weight: 500;
                margin: 20px auto;
                display: block;
            }
            .banner {
                background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), url('https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
                background-size: cover;
                background-position: center;
                padding: 100px 0;
                margin-bottom: 40px;
                color: white;
                text-align: center;
            }
            .banner h2 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>

        <!-- Banner/Hero Section -->
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Giày thể thao">
                    <div class="carousel-caption d-none d-md-block">
                        <h2>Giày Chất Lượng Cao</h2>
                        <p>Khám phá bộ sưu tập giày mới nhất với chất lượng tốt nhất</p>
                        <a href="#featured-products" class="btn btn-danger px-4 py-2">Mua ngay</a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="https://images.unsplash.com/photo-1549298916-b41d501d3772?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Giày thời trang">
                    <div class="carousel-caption d-none d-md-block">
                        <h2>Phong Cách Thời Trang</h2>
                        <p>Nâng tầm phong cách của bạn với bộ sưu tập giày độc đáo</p>
                        <a href="#featured-products" class="btn btn-danger px-4 py-2">Khám phá</a>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="https://images.unsplash.com/photo-1520256862855-398228c41684?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Giày thể thao">
                    <div class="carousel-caption d-none d-md-block">
                        <h2>Ưu Đãi Đặc Biệt</h2>
                        <p>Giảm giá lên đến 50% cho các sản phẩm mới</p>
                        <a href="#hot-deals" class="btn btn-danger px-4 py-2">Xem ngay</a>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <!-- Main Content -->
        <div class="container mt-5">
            <!-- Categories and Navigation -->
            <div class="row">
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Home.jsp">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="#">Danh mục</a></li>
                            <li class="breadcrumb-item active" aria-current="#">Tất cả sản phẩm</li>
                        </ol>
                    </nav>
                </div>
            </div>

            <!-- Hot Deals Section -->
            <section id="hot-deals" class="mb-5">
                <h2 class="section-title">Ưu Đãi Hot</h2>
                <div class="row">
                    <c:forEach items="${listP}" var="o" begin="0" end="3">
                        <div class="col-md-3 mb-4">
                            <div class="card">
                                <span class="badge-offer">-20%</span>
                                <img class="card-img-top" src="${o.image}" alt="${o.name}">
                                <div class="card-body">
                                    <div class="product-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span class="text-muted ml-1">(4.5)</span>
                                    </div>
                                    <h4 class="card-title show_txt"><a href="detail?pid=${o.id}" title="View Product">${o.name}</a></h4>
                                    <p class="card-text show_txt">${o.title}</p>
                                    <div class="row">
                                        <div class="col">
                                            <p class="btn btn-danger btn-block">${o.price} $</p>
                                        </div>
                                        <div class="col">
                                            <a href="cart?action=add&pid=${o.id}" class="btn btn-success btn-block">Thêm vào giỏ</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>

            <!-- Products Section -->
            <div class="row" id="featured-products">
                <jsp:include page="Left.jsp"></jsp:include>

                <div class="col-md-9">
                    <h2 class="section-title">Sản phẩm nổi bật</h2>
                    <div id="content" class="row">
                        <c:forEach items="${listP}" var="o">
                            <div class="product col-md-4">
                                <div class="card">
                                    <img class="card-img-top" src="${o.image}" alt="${o.name}">
                                    <div class="card-body">
                                        <div class="product-rating">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                            <span class="text-muted ml-1">(4.0)</span>
                                        </div>
                                        <h4 class="card-title show_txt"><a href="detail?pid=${o.id}" title="View Product">${o.name}</a></h4>
                                        <p class="card-text show_txt">${o.title}</p>
                                        <div class="row">
                                            <div class="col">
                                                <p class="btn btn-danger btn-block">${o.price} $</p>
                                            </div>
                                            <div class="col">
                                                <a href="cart?action=add&pid=${o.id}" class="btn btn-success btn-block">Thêm vào giỏ</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <button onclick="loadMore()" class="btn btn-load-more">Xem thêm sản phẩm</button>
                </div>
            </div>
            
            <!-- Call to Action Banner -->
            <div class="banner mb-4">
                <div class="container">
                    <h2>ĐĂNG KÝ NHẬN THÔNG TIN</h2>
                    <p class="lead">Nhận thông báo về các sản phẩm mới và ưu đãi đặc biệt.</p>
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="input-group mb-3">
                                <input type="email" class="form-control" placeholder="Email của bạn" aria-label="Email của bạn">
                                <div class="input-group-append">
                                    <button class="btn btn-danger" type="button">Đăng ký</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Brand Logos Section -->
            <section class="mb-5">
                <h2 class="section-title">Thương hiệu nổi tiếng</h2>
                <div class="row text-center">
                    <div class="col-md-2 col-4 mb-3">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Logo_NIKE.svg/1200px-Logo_NIKE.svg.png" alt="Nike" class="img-fluid" style="height: 60px;">
                    </div>
                    <div class="col-md-2 col-4 mb-3">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/2/20/Adidas_Logo.svg" alt="Adidas" class="img-fluid" style="height: 60px;">
                    </div>
                    <div class="col-md-2 col-4 mb-3">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/4/49/Puma_AG.svg" alt="Puma" class="img-fluid" style="height: 60px;">
                    </div>
                    <div class="col-md-2 col-4 mb-3">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/3/30/Converse_logo.svg" alt="Converse" class="img-fluid" style="height: 60px;">
                    </div>
                    <div class="col-md-2 col-4 mb-3">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Reebok_Logo.svg/1280px-Reebok_Logo.svg.png" alt="Reebok" class="img-fluid" style="height: 60px;">
                    </div>
                    <div class="col-md-2 col-4 mb-3">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Asics_Logo.svg/2560px-Asics_Logo.svg.png" alt="Asics" class="img-fluid" style="height: 60px;">
                    </div>
                </div>
            </section>
        </div>

        <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(){
                // Auto-play carousel
                $('.carousel').carousel({
                    interval: 5000
                });
            });
            
            function loadMore() {
                var amount = document.getElementsByClassName("product").length;
                $.ajax({
                    url: "/prj301/load",
                    type: "get",
                    data: {
                        exits: amount
                    },
                    success: function (data) {
                        var row = document.getElementById("content");
                        row.innerHTML += data;
                    },
                    error: function (xhr) {
                        console.log("Error loading more products");
                    }
                });
            }
            
            function searchByName(param) {
                var txtSearch = param.value;
                $.ajax({
                    url: "/prj301/searchAjax",
                    type: "get",
                    data: {
                        txt: txtSearch
                    },
                    success: function (data) {
                        var row = document.getElementById("content");
                        row.innerHTML = data;
                    },
                    error: function (xhr) {
                        console.log("Error searching products");
                    }
                });
            }
        </script>  
    </body>
</html>

