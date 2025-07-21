<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Result</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
        
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h3 class="text-center">Payment Result</h3>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${success == true}">
                                    <div class="alert alert-success text-center">
                                        <i class="fa fa-check-circle fa-4x mb-3"></i>
                                        <h3>Payment Successful!</h3>
                                        <p>${message}</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-danger text-center">
                                        <i class="fa fa-times-circle fa-4x mb-3"></i>
                                        <h3>Payment Failed!</h3>
                                        <p>${message}</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            
                            <div class="transaction-details mt-4">
                                <h4>Transaction Details</h4>
                                <table class="table table-bordered">
                                    <tr>
                                        <th>Order Info:</th>
                                        <td>${orderInfo}</td>
                                    </tr>
                                    <tr>
                                        <th>Amount:</th>
                                        <td>${Integer.parseInt(amount)/100} VND</td>
                                    </tr>
                                    <tr>
                                        <th>Payment Date:</th>
                                        <td>${payDate}</td>
                                    </tr>
                                    <tr>
                                        <th>Transaction No:</th>
                                        <td>${transactionNo}</td>
                                    </tr>
                                    <tr>
                                        <th>Bank Code:</th>
                                        <td>${bankCode}</td>
                                    </tr>
                                    <tr>
                                        <th>Card Type:</th>
                                        <td>${cardType}</td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div class="text-center mt-4">
                                <a href="home" class="btn btn-primary">Continue Shopping</a>
                            </div>
                        </div>
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