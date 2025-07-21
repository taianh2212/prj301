/*
 * Cart Controller
 */
package control;

import dao.DAO;
import entity.CartItem;
import entity.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author lethanhnhan
 */
@WebServlet(name = "CartControl", urlPatterns = {"/cart"})
public class CartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        
        // Get cart from session or create new one
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
        String action = request.getParameter("action");
        
        if (action != null && action.equals("add")) {
            // Get product ID and quantity
            String productId = request.getParameter("pid");
            String quantityStr = request.getParameter("quantity");
            int quantity = 1; // Default quantity
            
            if (quantityStr != null && !quantityStr.isEmpty()) {
                try {
                    quantity = Integer.parseInt(quantityStr);
                } catch (NumberFormatException e) {
                    // Use default quantity if parsing fails
                }
            }
            
            // Get product from database
            DAO dao = new DAO();
            Product product = dao.getProductByID(productId);
            
            if (product != null) {
                // Check if product already exists in cart
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == product.getId()) {
                        // Product exists, update quantity
                        item.setQuantity(item.getQuantity() + quantity);
                        found = true;
                        break;
                    }
                }
                
                // If product not found, add new item to cart
                if (!found) {
                    cart.add(new CartItem(product, quantity));
                }
            }
            
            // Redirect to previous page or referer
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect("home");
            }
            return;
        } else if (action != null && action.equals("remove")) {
            // Remove item from cart
            String productId = request.getParameter("pid");
            if (productId != null) {
                int pid = Integer.parseInt(productId);
                for (int i = 0; i < cart.size(); i++) {
                    if (cart.get(i).getProduct().getId() == pid) {
                        cart.remove(i);
                        break;
                    }
                }
            }
            response.sendRedirect("cart");
            return;
        } else if (action != null && action.equals("update")) {
            // Update item quantity
            String productId = request.getParameter("pid");
            String quantityStr = request.getParameter("quantity");
            
            if (productId != null && quantityStr != null) {
                int pid = Integer.parseInt(productId);
                int quantity = Integer.parseInt(quantityStr);
                
                if (quantity <= 0) {
                    // Remove item if quantity is 0 or negative
                    for (int i = 0; i < cart.size(); i++) {
                        if (cart.get(i).getProduct().getId() == pid) {
                            cart.remove(i);
                            break;
                        }
                    }
                } else {
                    // Update quantity
                    for (CartItem item : cart) {
                        if (item.getProduct().getId() == pid) {
                            item.setQuantity(quantity);
                            break;
                        }
                    }
                }
            }
            response.sendRedirect("cart");
            return;
        }
        
        // Calculate total amount
        double totalAmount = 0;
        for (CartItem item : cart) {
            totalAmount += item.getTotal();
        }
        
        // Set attributes and forward to cart page
        request.setAttribute("list", cart);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("Cart.jsp").forward(request, response);
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
        return "Cart Controller";
    }
} 