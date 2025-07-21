<%-- 
    Document   : Cart
    Created on : Oct 31, 2020, 9:42:21 PM
    Author     : trinh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>

    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="shopping-cart">
                <div class="px-4 px-lg-0">

                    <div class="pb-5">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">

                                    <!-- Error message if payment failed -->
                                    <c:if test="${not empty sessionScope.paymentError}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <strong>Lỗi thanh toán:</strong> ${sessionScope.paymentError}
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <c:remove var="paymentError" scope="session" />
                                    </c:if>

                                    <!-- Shopping cart table -->
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="p-2 px-3 text-uppercase">Sản Phẩm</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Đơn Giá</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Số Lượng</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Thành Tiền</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Xóa</div>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${list}" var="o">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="p-2">
                                                            <img src="${o.product.image}" alt="" width="70" class="img-fluid rounded shadow-sm">
                                                            <div class="ml-3 d-inline-block align-middle">
                                                                <h5 class="mb-0"> <a href="detail?pid=${o.product.id}" class="text-dark d-inline-block">${o.product.name}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
                                                            </div>
                                                        </div>
                                                    </th>
                                                    <td class="align-middle"><strong><fmt:formatNumber type="number" maxFractionDigits="2" value="${o.product.price}"/> $</strong></td>
                                                    <td class="align-middle">
                                                        <form action="cart" method="get" class="quantity-form">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="pid" value="${o.product.id}">
                                                            <a href="javascript:void(0)" class="btn btn-sm btn-decrement">-</a> 
                                                            <input type="number" name="quantity" value="${o.quantity}" min="1" class="quantity-input" style="width:50px;text-align:center;"> 
                                                            <a href="javascript:void(0)" class="btn btn-sm btn-increment">+</a>
                                                            <button type="submit" class="btn btn-sm btn-primary ml-2">Update</button>
                                                        </form>
                                                    </td>
                                                    <td class="align-middle"><strong><fmt:formatNumber type="number" maxFractionDigits="2" value="${o.total}"/> $</strong></td>
                                                    <td class="align-middle">
                                                        <a href="cart?action=remove&pid=${o.product.id}" class="text-dark">
                                                            <button type="button" class="btn btn-danger">Delete</button>
                                                        </a>
                                                    </td>
                                                </tr> 
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- End -->
                            </div>
                        </div>

                        <div class="row py-5 p-4 bg-white rounded shadow-sm">
                            <div class="col-lg-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Voucher</div>
                                <div class="p-4">
                                    <div class="input-group mb-4 border rounded-pill p-2">
                                        <input type="text" placeholder="Nhập Voucher" aria-describedby="button-addon3" class="form-control border-0">
                                        <div class="input-group-append border-0">
                                            <button id="button-addon3" type="button" class="btn btn-dark px-4 rounded-pill"><i class="fa fa-gift mr-2"></i>Sử dụng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Thành tiền</div>
                                <div class="p-4">
                                    <ul class="list-unstyled mb-4">
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng tiền hàng</strong><strong><fmt:formatNumber type="number" maxFractionDigits="2" value="${totalAmount}"/> $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Phí vận chuyển</strong><strong>Free ship</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">VAT</strong><strong><fmt:formatNumber type="number" maxFractionDigits="2" value="${totalAmount * 0.1}"/> $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng thanh toán</strong>
                                            <h5 class="font-weight-bold"><fmt:formatNumber type="number" maxFractionDigits="2" value="${totalAmount * 1.1}"/> $</h5>
                                        </li>
                                    </ul>
                                    
                                    <!-- Payment options -->
                                    <div class="payment-options">
                                        <h5 class="mb-3">Phương thức thanh toán</h5>
                                        
                                        <!-- Cash on delivery -->
                                        <a href="#" class="btn btn-dark rounded-pill py-2 btn-block mb-2">Thanh toán khi nhận hàng</a>
                                        
                                        <!-- VNPay payment -->
                                        <form action="vnpay" method="post">
                                            <input type="hidden" name="vnp_OrderInfo" value="Thanh toan don hang">
                                            <input type="hidden" name="ordertype" value="billpayment">
                                            <button type="submit" class="btn btn-primary rounded-pill py-2 btn-block">
                                                <img src="https://sandbox.vnpayment.vn/paymentv2/images/icons/logo_vnpay.svg" alt="VNPay" height="24" class="mr-2">
                                                Thanh toán qua VNPay
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center mt-3">
                            <a href="home" class="btn btn-primary">Tiếp tục mua hàng</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script>
            // Quantity increment and decrement buttons
            document.querySelectorAll('.btn-increment').forEach(button => {
                button.addEventListener('click', function() {
                    const input = this.parentNode.querySelector('.quantity-input');
                    input.value = parseInt(input.value) + 1;
                });
            });
            
            document.querySelectorAll('.btn-decrement').forEach(button => {
                button.addEventListener('click', function() {
                    const input = this.parentNode.querySelector('.quantity-input');
                    const value = parseInt(input.value);
                    if (value > 1) {
                        input.value = value - 1;
                    }
                });
            });
        </script>
    </body>
</html>

