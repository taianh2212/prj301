<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán thất bại</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .failed-container {
                max-width: 800px;
                margin: 50px auto;
                text-align: center;
            }
            .payment-icon {
                font-size: 90px;
                color: #dc3545;
                margin-bottom: 25px;
            }
            .card {
                border: none;
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15);
                padding: 30px;
            }
            .error-details {
                background-color: #fff8f8;
                padding: 20px;
                border-radius: 5px;
                margin: 30px 0;
                text-align: left;
                border-left: 5px solid #dc3545;
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
            .payment-options {
                margin-top: 30px;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 5px;
                text-align: left;
            }
            .payment-option {
                padding: 10px;
                margin-bottom: 10px;
                border-bottom: 1px solid #eee;
            }
            .payment-option:last-child {
                border-bottom: none;
            }
            .transaction-details {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                margin: 30px 0;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="container failed-container">
            <div class="card">
                <i class="fas fa-times-circle payment-icon"></i>
                <h2>Thanh toán thất bại <span class="badge badge-vnpay">VNPay</span></h2>
                <p class="lead">${message}</p>
                
                <div class="error-details">
                    <h5><i class="fas fa-exclamation-triangle mr-2"></i>Lý do thanh toán không thành công:</h5>
                    <p>${message}</p>
                    <ul class="text-left mt-3">
                        <li>Kiểm tra lại thông tin thẻ/tài khoản của bạn</li>
                        <li>Kiểm tra hạn mức thẻ và số dư tài khoản</li>
                        <li>Liên hệ với ngân hàng của bạn nếu cần hỗ trợ</li>
                    </ul>
                </div>
                
                <c:if test="${not empty transactionNo || not empty amount}">
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
                                        <c:set var="formattedAmount" value="${Integer.parseInt(amount)/100}" />
                                        <strong><fmt:formatNumber type="number" pattern="#,##0 VND" value="${formattedAmount}" /></strong>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty orderInfo}">
                                <tr>
                                    <th>Thông tin đơn hàng:</th>
                                    <td>${orderInfo}</td>
                                </tr>
                            </c:if>
                        </table>
                    </div>
                </c:if>
                
                <div class="payment-options">
                    <h5 class="mb-3"><i class="fas fa-credit-card mr-2"></i>Các phương thức thanh toán khác:</h5>
                    <div class="payment-option">
                        <strong><i class="fas fa-money-bill mr-2"></i>Thanh toán khi nhận hàng (COD)</strong>
                        <p class="text-muted mb-0">Thanh toán tiền mặt khi đơn hàng được giao đến.</p>
                    </div>
                    <div class="payment-option">
                        <strong><i class="fas fa-credit-card mr-2"></i>Thử lại thanh toán VNPay</strong>
                        <p class="text-muted mb-0">Sử dụng thẻ ngân hàng, ví điện tử hoặc QR code.</p>
                    </div>
                    <div class="payment-option">
                        <strong><i class="fas fa-phone-alt mr-2"></i>Hỗ trợ thanh toán</strong>
                        <p class="text-muted mb-0">Gọi <strong>1900 1234</strong> để được nhân viên hỗ trợ thanh toán.</p>
                    </div>
                </div>
                
                <div class="mt-4">
                    <a href="cart" class="btn btn-primary mr-3">
                        <i class="fas fa-shopping-cart"></i> Quay lại giỏ hàng
                    </a>
                    <a href="home" class="btn btn-outline-secondary">
                        <i class="fas fa-home"></i> Trang chủ
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