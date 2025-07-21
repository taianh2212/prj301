package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PaymentResultControl", urlPatterns = {"/payment-success", "/payment-failed"})
public class PaymentResultControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Determine which page to show based on the URL pattern
        String uri = request.getRequestURI();
        String page = "PaymentFailed.jsp"; // Default to failed
        
        if (uri.contains("payment-success")) {
            page = "PaymentSuccess.jsp";
        }
        
        // Get parameters from request if available
        String amount = request.getParameter("amount");
        String message = request.getParameter("message");
        String transactionNo = request.getParameter("transactionNo");
        String payDate = request.getParameter("payDate");
        String orderInfo = request.getParameter("orderInfo");
        String bankCode = request.getParameter("bankCode");
        
        // Set default message if none provided
        if (message == null || message.isEmpty()) {
            if (page.equals("PaymentSuccess.jsp")) {
                message = "Thanh toán thành công";
            } else {
                message = "Thanh toán thất bại";
            }
        }
        
        // Set attributes for the JSP
        request.setAttribute("message", message);
        request.setAttribute("amount", amount);
        request.setAttribute("transactionNo", transactionNo);
        request.setAttribute("payDate", payDate);
        request.setAttribute("orderInfo", orderInfo);
        request.setAttribute("bankCode", bankCode);
        request.setAttribute("success", page.equals("PaymentSuccess.jsp"));
        
        // Forward to the appropriate page
        request.getRequestDispatcher(page).forward(request, response);
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
        return "Payment Result Controller";
    }
} 