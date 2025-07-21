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

@WebServlet(name = "OrderHistoryControl", urlPatterns = {"/order-history"})
public class OrderHistoryControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Get logged in user
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("acc");
            
            if (account == null) {
                // Redirect to login if not logged in
                response.sendRedirect("Login.jsp");
                return;
            }
            
            // Check if we need order details
            String action = request.getParameter("action");
            if (action != null && action.equals("view")) {
                String orderIdStr = request.getParameter("id");
                if (orderIdStr != null) {
                    try {
                        int orderId = Integer.parseInt(orderIdStr);
                        DAO dao = new DAO();
                        Order order = dao.getOrderById(orderId);
                        
                        // Verify the order belongs to this user
                        if (order != null && order.getAccountId() == account.getId()) {
                            request.setAttribute("order", order);
                            request.getRequestDispatcher("OrderDetail.jsp").forward(request, response);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        // Invalid order ID, continue to show order list
                    }
                }
            }
            
            // Get all orders for this user
            DAO dao = new DAO();
            List<Order> orders = dao.getOrdersByAccountId(account.getId());
            
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("OrderHistory.jsp").forward(request, response);
            
        } catch (Exception e) {
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