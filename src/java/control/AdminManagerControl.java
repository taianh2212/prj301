package control;

import dao.DAO;
import entity.Account;
import entity.Product;
import java.io.IOException;
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
@WebServlet(name = "AdminManagerControl", urlPatterns = {"/admin-manager"})
public class AdminManagerControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // Check if user is admin
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        if (account == null || account.getIsAdmin() != 1) {
            response.sendRedirect("home");
            return;
        }
        
        // Initialize DAO
        DAO dao = new DAO();
        
        // Fetch all users and products
        List<Account> accounts = dao.getAllAccounts();
        List<Product> products = dao.getAllProduct();
        
        // Set attributes for the JSP
        request.setAttribute("accounts", accounts);
        request.setAttribute("products", products);
        request.setAttribute("totalUsers", accounts.size());
        request.setAttribute("totalProducts", products.size());
        
        request.getRequestDispatcher("admin/manager.jsp").forward(request, response);
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
        return "Admin Manager Controller";
    }
} 