package control;

import config.VNPayConfig;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import entity.CartItem;
import java.util.List;

@WebServlet(name = "VNPayReturnController", urlPatterns = {"/vnpay-return"})
public class VNPayReturnController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Extract all parameters from VNPay response
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        // Get secure hash from VNPay response
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }

        // Check if VNPay response code is successful (00 means success)
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");

        // Validate the response
        boolean checkSignature = VNPayConfig.hashAllFields(fields).equals(vnp_SecureHash);

        boolean paymentSuccess = false;
        String paymentMessage = "";
        
        if (checkSignature) {
            // Check payment status
            if ("00".equals(vnp_ResponseCode) && "00".equals(vnp_TransactionStatus)) {
                // Payment success
                paymentSuccess = true;
                paymentMessage = "Thanh toán thành công";
                
                // Clear cart after successful payment
                HttpSession session = request.getSession();
                session.removeAttribute("cart");
            } else {
                // Payment failed
                paymentMessage = "Thanh toán không thành công. Mã lỗi: " + vnp_ResponseCode;
            }
        } else {
            // Invalid signature
            paymentMessage = "Có lỗi xảy ra trong quá trình xử lý";
        }

        // Get transaction details
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
        String vnp_PayDate = request.getParameter("vnp_PayDate");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_BankCode = request.getParameter("vnp_BankCode");
        String vnp_CardType = request.getParameter("vnp_CardType");

        // Set response attributes
        request.setAttribute("success", paymentSuccess);
        request.setAttribute("message", paymentMessage);
        request.setAttribute("amount", vnp_Amount);
        request.setAttribute("orderInfo", vnp_OrderInfo);
        request.setAttribute("payDate", vnp_PayDate);
        request.setAttribute("transactionNo", vnp_TransactionNo);
        request.setAttribute("bankCode", vnp_BankCode);
        request.setAttribute("cardType", vnp_CardType);

        // Forward to payment result page
        request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
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
        return "VNPay Return Controller";
    }
} 