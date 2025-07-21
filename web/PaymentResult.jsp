<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kết quả thanh toán</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .result-container {
                max-width: 800px;
                margin: 30px auto;
            }
            .payment-icon {
                font-size: 72px;
                margin-bottom: 20px;
            }
            .payment-success {
                color: #28a745;
            }
            .payment-failed {
                color: #dc3545;
            }
            .result-message {
                margin-bottom: 30px;
            }
            .transaction-details {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                margin-bottom: 30px;
            }
            .action-buttons {
                margin-top: 20px;
            }
            .order-summary {
                margin-top: 15px;
                font-size: 18px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="container result-container">
            <div class="card">
                <div class="card-body text-center">
                    <c:choose>
                        <c:when test="${success == true}">
                            <i class="fas fa-check-circle payment-icon payment-success"></i>
                            <h2 class="card-title">Thanh toán thành công!</h2>
                            <p class="result-message">${message}</p>
                            <div class="order-summary">
                                Đơn hàng của bạn đã được xác nhận và sẽ được giao trong 3-5 ngày làm việc.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-times-circle payment-icon payment-failed"></i>
                            <h2 class="card-title">Thanh toán thất bại</h2>
                            <p class="result-message">${message}</p>
                            <div class="alert alert-info" role="alert">
                                <i class="fas fa-info-circle"></i> Vui lòng thử lại hoặc chọn phương thức thanh toán khác.
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:if test="${not empty transactionNo}">
                        <div class="transaction-details">
                            <h4>Chi tiết giao dịch</h4>
                            <table class="table table-striped">
                                <tr>
                                    <th>Mã giao dịch:</th>
                                    <td>${transactionNo}</td>
                                </tr>
                                <tr>
                                    <th>Số tiền:</th>
                                    <td>
                                        <c:if test="${not empty amount}">
                                            <c:set var="formattedAmount" value="${Integer.parseInt(amount)/100}" />
                                            <fmt:formatNumber type="number" pattern="#,###" value="${formattedAmount}" /> VND
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Ngày thanh toán:</th>
                                    <td>${payDate}</td>
                                </tr>
                                <tr>
                                    <th>Thông tin đơn hàng:</th>
                                    <td>${orderInfo}</td>
                                </tr>
                                <c:if test="${not empty bankCode}">
                                    <tr>
                                        <th>Ngân hàng:</th>
                                        <td>${bankCode}</td>
                                    </tr>
                                </c:if>
                            </table>
                        </div>
                    </c:if>
                    
                    <div class="action-buttons">
                        <a href="home" class="btn btn-primary mr-2">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                        <c:choose>
                            <c:when test="${success == true}">
                                <a href="user" class="btn btn-success">
                                    <i class="fas fa-list"></i> Xem đơn hàng
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="cart" class="btn btn-danger">
                                    <i class="fas fa-shopping-cart"></i> Quay lại giỏ hàng
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        
        <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html> 