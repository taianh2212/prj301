<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán thành công</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .success-container {
                max-width: 800px;
                margin: 50px auto;
                text-align: center;
            }
            .payment-icon {
                font-size: 90px;
                color: #28a745;
                margin-bottom: 25px;
            }
            .card {
                border: none;
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15);
                padding: 30px;
            }
            .transaction-details {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                margin: 30px 0;
                text-align: left;
            }
            .badge-vnpay {
                background-color: #004a9f;
                color: white;
                font-size: 14px;
                padding: 5px 10px;
                border-radius: 4px;
                margin-left: 10px;
                vertical-align: middle;
            }
            .order-info {
                background-color: #e8f4fc;
                padding: 15px;
                border-radius: 5px;
                border-left: 5px solid #007bff;
                margin: 20px 0;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="container success-container">
            <div class="card">
                <i class="fas fa-check-circle payment-icon"></i>
                <h2>Thanh toán thành công! <span class="badge badge-vnpay">VNPay</span></h2>
                <p class="lead">${message}</p>
                
                <div class="order-info">
                    <i class="fas fa-info-circle mr-2"></i>
                    Đơn hàng của bạn đã được xác nhận và sẽ được giao trong 3-5 ngày làm việc.
                    <c:if test="${not empty orderId}">
                        <div class="mt-2">
                            <strong>Mã đơn hàng:</strong> #${orderId}
                            <br>
                            <a href="order-history?action=view&id=${orderId}" class="text-primary">
                                <i class="fas fa-eye"></i> Xem chi tiết đơn hàng
                            </a>
                        </div>
                    </c:if>
                    <c:if test="${not empty transactionNo}">
                        <div class="mt-2">
                            <strong>Mã giao dịch:</strong> ${transactionNo}
                        </div>
                    </c:if>
                </div>
                
                <div class="transaction-details">
                    <h4 class="mb-4"><i class="fas fa-receipt mr-2"></i>Chi tiết giao dịch</h4>
                    <table class="table table-striped">
                        <c:if test="${not empty transactionNo}">
                            <tr>
                                <th width="40%">Mã giao dịch:</th>
                                <td>${transactionNo}</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty amount}">
                            <tr>
                                <th>Số tiền:</th>
                                <td>
                                    <strong><fmt:formatNumber type="number" pattern="#,##0 VND" value="${amount}" /></strong>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty payDate}">
                            <tr>
                                <th>Ngày thanh toán:</th>
                                <td>${payDate}</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty orderInfo}">
                            <tr>
                                <th>Thông tin đơn hàng:</th>
                                <td>${orderInfo}</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty bankCode}">
                            <tr>
                                <th>Ngân hàng:</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${bankCode eq 'NCB'}">
                                            <strong>Ngân hàng Quốc Dân (NCB)</strong>
                                        </c:when>
                                        <c:when test="${bankCode eq 'VNBANK' || bankCode eq 'INTCARD'}">
                                            <strong>${bankCode}</strong>
                                        </c:when>
                                        <c:otherwise>
                                            <strong>${bankCode}</strong>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </div>
                
                <div class="mt-4">
                    <a href="home" class="btn btn-primary mr-3">
                        <i class="fas fa-home"></i> Trang chủ
                    </a>
                    <a href="order-history" class="btn btn-success">
                        <i class="fas fa-list"></i> Lịch sử đơn hàng
                    </a>
                </div>
            </div>
        </div>
        
        <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html> 