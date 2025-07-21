<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh toán thành công</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
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
        <%@include file="Menu.jsp" %>
        
        <div class="container mt-5 mb-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header bg-success text-white">
                            <h4 class="mb-0"><i class="fa fa-check-circle"></i> Thanh toán thành công</h4>
                        </div>
                        <div class="card-body">
                            <div class="text-center mb-4">
                                <i class="fa fa-check-circle text-success" style="font-size: 5rem;"></i>
                            </div>
                            
                            <h3 class="text-center">Cảm ơn bạn đã mua hàng!</h3>
                            <p class="text-center">Đơn hàng của bạn đã được xác nhận.</p>
                            
                            <div class="payment-details mt-4">
                                <h5>Chi tiết thanh toán:</h5>
                                <hr>
                                <p><strong>Mã giao dịch:</strong> ${transactionNo}</p>
                                <p><strong>Số tiền:</strong> <fmt:formatNumber value="${amount}" type="number"/> VNĐ</p>
                                <p><strong>Phương thức:</strong> ${bankCode} (${cardType})</p>
                                <p><strong>Thời gian:</strong> ${payDate}</p>
                                <p><strong>Nội dung:</strong> ${orderInfo}</p>
                            </div>
                            
                            <div class="text-center mt-4">
                                <a href="home" class="btn btn-primary">
                                    <i class="fa fa-shopping-cart"></i> Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            
        <%@include file="Footer.jsp" %>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    </body>
</html> 