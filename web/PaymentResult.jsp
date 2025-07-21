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
                font-size: 90px;
                margin-bottom: 25px;
            }
            .payment-success {
                color: #28a745;
            }
            .payment-failed {
                color: #dc3545;
            }
            .result-message {
                margin-bottom: 30px;
                font-size: 18px;
            }
            .transaction-details {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                margin-bottom: 30px;
            }
            .action-buttons {
                margin-top: 30px;
            }
            .order-summary {
                margin-top: 25px;
                font-size: 18px;
                padding: 15px;
                background-color: #e8f4fc;
                border-radius: 5px;
                border-left: 5px solid #007bff;
            }
            .debug-info {
                font-family: monospace;
                font-size: 12px;
                background: #333;
                color: #fff;
                padding: 15px;
                border-radius: 5px;
                white-space: pre-wrap;
                margin-top: 30px;
                max-height: 200px;
                overflow: auto;
            }
            .debug-toggle {
                margin-top: 30px;
                text-align: center;
            }
            .card {
                border: none;
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15);
            }
            .card-body {
                padding: 2.5rem;
            }
            h2.card-title {
                margin-bottom: 1.5rem;
                font-weight: 600;
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
            .bank-info {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }
            .bank-logo {
                height: 30px;
                margin-right: 10px;
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
                            <h2 class="card-title">Thanh toán thành công! <span class="badge badge-vnpay">VNPay</span></h2>
                            <p class="result-message">${message}</p>
                            <div class="order-summary">
                                <i class="fas fa-info-circle mr-2"></i>
                                Đơn hàng của bạn đã được xác nhận và sẽ được giao trong 3-5 ngày làm việc.
                                <c:if test="${not empty transactionNo}">
                                    <div class="mt-2">
                                        <strong>Mã giao dịch:</strong> ${transactionNo}
                                    </div>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-times-circle payment-icon payment-failed"></i>
                            <h2 class="card-title">Thanh toán thất bại <span class="badge badge-vnpay">VNPay</span></h2>
                            <p class="result-message">${message}</p>
                            <div class="alert alert-info" role="alert">
                                <i class="fas fa-info-circle"></i> Vui lòng thử lại hoặc chọn phương thức thanh toán khác.
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:if test="${not empty transactionNo || not empty amount}">
                        <div class="transaction-details">
                            <h4 class="mb-4"><i class="fas fa-receipt mr-2"></i>Chi tiết giao dịch</h4>
                            <table class="table table-striped">
                                <c:if test="${not empty transactionNo}">
                                    <tr>
                                        <th>Mã giao dịch:</th>
                                        <td>${transactionNo}</td>
                                    </tr>
                                </c:if>
                                <c:if test="${not empty amount}">
                                    <tr>
                                        <th>Số tiền:</th>
                                        <td>
                                            <c:set var="formattedAmount" value="${Integer.parseInt(amount)/100}" />
                                            <strong>${formattedAmount} VND</strong>
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
                                            <div class="bank-info">
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
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </table>
                        </div>
                    </c:if>
                    
                    <div class="action-buttons">
                        <a href="home" class="btn btn-primary mr-3">
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
                    
                    <div class="debug-toggle mt-5">
                        <button class="btn btn-sm btn-secondary" onclick="toggleDebug()">
                            <i class="fas fa-bug"></i> Hiển thị thông tin gỡ lỗi
                        </button>
                    </div>
                    
                    <div id="debugInfo" class="debug-info mt-3" style="display: none;">
                        <strong>Debug Information:</strong>
                        <br/>
                        <c:forEach items="${pageContext.request.parameterMap}" var="parameter">
                            ${parameter.key}: ${parameter.value[0]}<br/>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        
        <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            function toggleDebug() {
                var debugInfo = document.getElementById('debugInfo');
                if (debugInfo.style.display === 'none') {
                    debugInfo.style.display = 'block';
                } else {
                    debugInfo.style.display = 'none';
                }
            }
        </script>
    </body>
</html> 