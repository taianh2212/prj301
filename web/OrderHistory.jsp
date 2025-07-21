<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lịch sử mua hàng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .order-table {
            margin-top: 20px;
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
        .debug-section {
            background-color: #f8d7da;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #f5c6cb;
        }
        .debug-title {
            color: #721c24;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    
    <div class="container mt-4">
        <h2>Lịch sử mua hàng</h2>
        
        <!-- Debug Section -->
        <div class="debug-section">
            <h4 class="debug-title">Debug Information</h4>
            <p><strong>Account in session:</strong> ${sessionScope.acc != null ? 'Yes' : 'No'}</p>
            <c:if test="${sessionScope.acc != null}">
                <p><strong>Account ID:</strong> ${sessionScope.acc.id}</p>
                <p><strong>Username:</strong> ${sessionScope.acc.user}</p>
            </c:if>
            <p><strong>Orders attribute exists:</strong> ${orders != null ? 'Yes' : 'No'}</p>
            <p><strong>Orders empty:</strong> ${empty orders ? 'Yes' : 'No'}</p>
            <c:if test="${orders != null && not empty orders}">
                <p><strong>Number of orders:</strong> ${orders.size()}</p>
                <p><strong>First order:</strong> ID=${orders[0].id}, Code=${orders[0].orderCode}</p>
            </c:if>
        </div>
        
        <c:if test="${empty orders}">
            <div class="alert alert-info mt-3">
                Bạn chưa có đơn hàng nào. <a href="home">Tiếp tục mua sắm</a>
            </div>
        </c:if>
        
        <c:if test="${not empty orders}">
            <div class="table-responsive order-table">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Trạng thái</th>
                            <th>Chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="o">
                            <tr>
                                <td>${o.orderCode}</td>
                                <td>${o.orderDate}</td>
                                <td><strong>${String.format("%,.0f", o.totalAmount)} VNĐ</strong></td>
                                <td>${o.paymentMethod}</td>
                                <td>
                                    <span class="order-status-${o.status.toLowerCase()}">${o.status}</span>
                                </td>
                                <td>
                                    <a href="order-history?action=view&id=${o.id}" class="btn btn-sm btn-primary">Xem chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="Footer.jsp"></jsp:include>
    
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html> 