<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DAO, entity.Order, java.util.List, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, context.DBContext" %>
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
        .db-check-section {
            background-color: #d1ecf1;
            padding: 15px;
            margin: 20px 0;
            border-radius: 5px;
            border: 1px solid #bee5eb;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    
    <div class="container mt-4">
        <h2>Lịch sử mua hàng</h2>
        
        <!-- Debug Information Section -->
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
        
        <!-- Direct Database Check Section -->
        <div class="db-check-section">
            <h4>Direct Database Check</h4>
            <p>This checks the Orders table directly:</p>
            
            <table class="table table-sm table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Account ID</th>
                        <th>Order Code</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        int rowCount = 0;
                        
                        try {
                            conn = new DBContext().getConnection();
                            String sql = "SELECT TOP 10 * FROM Orders ORDER BY order_date DESC";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            
                            while (rs.next()) {
                                rowCount++;
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getInt("account_id") %></td>
                        <td><%= rs.getString("order_code") %></td>
                        <td><%= String.format("%,.0f", rs.getDouble("total_amount")) %> VNĐ</td>
                        <td><%= rs.getTimestamp("order_date") %></td>
                        <td><%= rs.getString("status") %></td>
                    </tr>
                    <%
                            }
                            
                            if (rowCount == 0) {
                                out.println("<tr><td colspan='6' class='text-center'>Không có đơn hàng nào trong cơ sở dữ liệu.</td></tr>");
                            }
                            
                        } catch (Exception e) {
                            out.println("<tr><td colspan='6' class='text-danger'>Lỗi khi truy vấn cơ sở dữ liệu: " + e.getMessage() + "</td></tr>");
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (ps != null) ps.close(); } catch (Exception e) {}
                            try { if (conn != null) conn.close(); } catch (Exception e) {}
                        }
                    %>
                </tbody>
            </table>
            <p><strong>Total records found:</strong> <%= rowCount %></p>
        </div>
        
        <!-- Regular Order List -->
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