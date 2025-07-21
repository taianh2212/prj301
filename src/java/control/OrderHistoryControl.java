package control;

import dao.DAO;
import entity.Account;
import entity.Order;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;

@WebServlet(name = "OrderHistoryControl", urlPatterns = {"/order-history"})
public class OrderHistoryControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            System.out.println("------- OrderHistoryControl START -------");
            System.out.println("Request URL: " + request.getRequestURL().toString());
            System.out.println("Request URI: " + request.getRequestURI());
            System.out.println("Context Path: " + request.getContextPath());
            
            // Print all request parameters
            System.out.println("Request parameters:");
            Enumeration<String> paramNames = request.getParameterNames();
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                System.out.println("  " + paramName + "=" + paramValue);
            }
            
            // Get logged in user
            HttpSession session = request.getSession();
            System.out.println("Session ID: " + session.getId());
            
            Account account = (Account) session.getAttribute("acc");
            
            System.out.println("Session account: " + (account != null ? "found" : "null"));
            
            if (account == null) {
                // Redirect to login if not logged in
                System.out.println("Not logged in, redirecting to login page");
                response.sendRedirect("Login.jsp");
                return;
            }
            
            System.out.println("Account ID: " + account.getId());
            
            // Check if we need order details
            String action = request.getParameter("action");
            if (action != null && action.equals("view")) {
                String orderIdStr = request.getParameter("id");
                if (orderIdStr != null) {
                    try {
                        int orderId = Integer.parseInt(orderIdStr);
                        DAO dao = new DAO();
                        Order order = dao.getOrderById(orderId);
                        
                        System.out.println("Viewing order details for order ID: " + orderId + ", found: " + (order != null));
                        
                        // Verify the order belongs to this user
                        if (order != null && order.getAccountId() == account.getId()) {
                            request.setAttribute("order", order);
                            request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
                            return;
                        } else {
                            System.out.println("Order not found or doesn't belong to user");
                        }
                    } catch (NumberFormatException e) {
                        // Invalid order ID, continue to show order list
                        System.out.println("Invalid order ID: " + orderIdStr);
                    }
                }
            }
            
            // Get all orders for this user
            DAO dao = new DAO();
            List<Order> orders = dao.getOrdersByAccountId(account.getId());
            
            System.out.println("Found " + (orders != null ? orders.size() : 0) + " orders for account ID: " + account.getId());
            if (orders != null && !orders.isEmpty()) {
                System.out.println("First order: ID=" + orders.get(0).getId() + ", Code=" + orders.get(0).getOrderCode());
            }
            
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("OrderHistory.jsp").forward(request, response);
            System.out.println("------- OrderHistoryControl END -------");
            
        } catch (Exception e) {
            System.out.println("ERROR in OrderHistoryControl: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Order History Controller";
    }
} 