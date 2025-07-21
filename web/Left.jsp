

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-sm-3">
    <!-- Danh mục sản phẩm -->
    <div class="card bg-light mb-4">
        <div class="card-header bg-primary text-white text-uppercase">
            <i class="fas fa-list"></i> Danh mục sản phẩm
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
            <i class="fas fa-fire"></i> Sản phẩm mới nhất
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
            <p><i class="fas fa-envelope mr-2 text-primary"></i> support@shoes.com</p>
            <p class="mb-0"><i class="fas fa-clock mr-2 text-primary"></i> 8:00 AM - 10:00 PM</p>
        </div>
    </div>
</div>