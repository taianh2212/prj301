<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .order-detail {
            margin-top: 20px;
        }
        .order-summary {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .order-status-completed {
            color: green;
            font-weight: bold;
        }
        .order-status-pending {
            color: orange;
            font-weight: bold;
        }
        .order-status-cancelled {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    
    <div class="container mt-4">
        <c:if test="${empty order}">
            <div class="alert alert-warning">
                Không tìm thấy đơn hàng. <a href="order-history">Quay lại danh sách đơn hàng</a>
            </div>
        </c:if>
        
        <c:if test="${not empty order}">
            <h2>Chi tiết đơn hàng #${order.orderCode}</h2>
            
            <div class="order-detail">
                <div class="row">
                    <div class="col-md-6">
                        <div class="order-summary">
                            <h4>Thông tin đơn hàng</h4>
                            <table class="table table-borderless">
                                <tr>
                                    <th>Mã đơn hàng:</th>
                                    <td>${order.orderCode}</td>
                                </tr>
                                <tr>
                                    <th>Ngày đặt:</th>
                                    <td>${order.orderDate}</td>
                                </tr>
                                <tr>
                                    <th>Trạng thái:</th>
                                    <td><span class="order-status-${order.status.toLowerCase()}">${order.status}</span></td>
                                </tr>
                                <tr>
                                    <th>Phương thức thanh toán:</th>
                                    <td>${order.paymentMethod}</td>
                                </tr>
                                <tr>
                                    <th>Mã giao dịch:</th>
                                    <td>${order.transactionCode}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                
                <h4 class="mt-4">Sản phẩm đã mua</h4>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th class="text-right">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${order.orderItems}" var="item">
                                <tr>
                                    <td>${item.productName}</td>
                                    <td>${String.format("%,.0f", item.price)} VNĐ</td>
                                    <td>${item.quantity}</td>
                                    <td class="text-right">${String.format("%,.0f", item.subtotal)} VNĐ</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="3" class="text-right"><strong>Tổng cộng:</strong></td>
                                <td class="text-right"><strong>${String.format("%,.0f", order.totalAmount)} VNĐ</strong></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="mt-4">
                    <a href="order-history" class="btn btn-secondary">Quay lại danh sách đơn hàng</a>
                </div>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="Footer.jsp"></jsp:include>
    
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html> 