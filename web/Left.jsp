

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-sm-3">
    <!-- Danh mục sản phẩm -->
    <div class="card bg-light mb-4">
        <div class="card-header bg-primary text-white text-uppercase">
            <i class="fas fa-list"></i> Danh mục nhạc cụ
        </div>
        <ul class="list-group category_block">
            <c:forEach items="${listCC}" var="o">
                <li class="list-group-item ${tag == o.cid ? "active":""}">
                    <a href="category?cid=${o.cid}" class="${tag == o.cid ? "text-white":""}">
                        <i class="fas fa-angle-right mr-2"></i> ${o.cname}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <!-- Sản phẩm mới nhất -->
    <div class="card bg-light mb-4">
        <div class="card-header bg-success text-white text-uppercase">
            <i class="fas fa-fire"></i> Nhạc cụ mới nhất
        </div>
        <div class="card-body">
            <div class="product-top">
                <img class="img-fluid rounded mb-3" src="${p.image}" alt="${p.name}">
                <div class="product-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>
            <h5 class="card-title">
                <a href="detail?pid=${p.id}" class="text-dark">${p.name}</a>
            </h5>
            <p class="card-text text-muted mb-2">${p.title}</p>
            <div class="d-flex align-items-center justify-content-between mt-3">
                <p class="bloc_left_price">${p.price} $</p>
                <a href="cart?action=add&pid=${p.id}" class="btn btn-sm btn-success">
                    <i class="fas fa-cart-plus"></i> Thêm
                </a>
            </div>
        </div>
    </div>

    <!-- Hỗ trợ khách hàng -->
    <div class="card bg-light mb-4">
        <div class="card-header bg-info text-white text-uppercase">
            <i class="fas fa-headset"></i> Hỗ trợ
        </div>
        <div class="card-body">
            <p><i class="fas fa-phone-alt mr-2 text-primary"></i> +84 123 456 789</p>
            <p><i class="fas fa-envelope mr-2 text-primary"></i> support@musicstore.com</p>
            <p class="mb-0"><i class="fas fa-clock mr-2 text-primary"></i> 8:00 AM - 10:00 PM</p>
        </div>
    </div>
    
    <!-- Tin tức âm nhạc -->
    <div class="card bg-light mb-4">
        <div class="card-header bg-warning text-white text-uppercase">
            <i class="fas fa-music"></i> Tin tức âm nhạc
        </div>
        <div class="card-body p-2">
            <div class="mb-2">
                <a href="#" class="d-flex align-items-center text-dark text-decoration-none p-2">
                    <div class="mr-2" style="width: 60px; height: 60px; overflow: hidden;">
                        <img src="https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80" class="img-fluid rounded" alt="Music News">
                    </div>
                    <div>
                        <small class="text-muted d-block">24/07/2023</small>
                        <span class="small">Top 10 guitar acoustic tốt nhất năm 2023</span>
                    </div>
                </a>
            </div>
            <div class="mb-2">
                <a href="#" class="d-flex align-items-center text-dark text-decoration-none p-2">
                    <div class="mr-2" style="width: 60px; height: 60px; overflow: hidden;">
                        <img src="https://images.unsplash.com/photo-1511735111819-9a3f7709049c?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80" class="img-fluid rounded" alt="Music News">
                    </div>
                    <div>
                        <small class="text-muted d-block">20/07/2023</small>
                        <span class="small">Hướng dẫn chọn piano điện cho người mới học</span>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>