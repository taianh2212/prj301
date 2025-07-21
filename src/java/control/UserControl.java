package control;

import dao.DAO;
import entity.Account;
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
@WebServlet(name = "UserControl", urlPatterns = {"/user"})
public class UserControl extends HttpServlet {

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
        
        String action = request.getParameter("action");
        DAO dao = new DAO();
        
        if (action == null) {
            // List all users
            List<Account> listAccounts = dao.getAllAccounts();
            request.setAttribute("listAccounts", listAccounts);
            request.getRequestDispatcher("user/userList.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            // Delete user
            String userId = request.getParameter("id");
            if (userId != null && !userId.equals(String.valueOf(account.getId()))) {
                dao.deleteAccount(userId);
            }
            response.sendRedirect("user");
        } else if (action.equals("edit")) {
            // Show edit form for a user
            String userId = request.getParameter("id");
            Account user = dao.getAccountByID(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("user/editUser.jsp").forward(request, response);
        } else if (action.equals("update")) {
            // Update user details
            String id = request.getParameter("id");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String isSell = request.getParameter("isSell") != null ? request.getParameter("isSell") : "0";
            String isAdmin = request.getParameter("isAdmin") != null ? request.getParameter("isAdmin") : "0";
            
            if (id != null && username != null && password != null) {
                dao.updateAccount(id, username, password, isSell, isAdmin);
            }
            response.sendRedirect("user");
        } else if (action.equals("create")) {
            // Show create user form
            if ("GET".equalsIgnoreCase(request.getMethod())) {
                request.getRequestDispatcher("user/createUser.jsp").forward(request, response);
            } else {
                // Process create user form submission
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String isSell = request.getParameter("isSell") != null ? request.getParameter("isSell") : "0";
                String isAdmin = request.getParameter("isAdmin") != null ? request.getParameter("isAdmin") : "0";
                
                if (username != null && password != null) {
                    Account existingAccount = dao.checkAccountExist(username);
                    if (existingAccount == null) {
                        dao.insertAccount(username, password, isSell, isAdmin);
                        response.sendRedirect("user");
                    } else {
                        request.setAttribute("errorMessage", "Username already exists");
                        request.getRequestDispatcher("user/createUser.jsp").forward(request, response);
                    }
                } else {
                    response.sendRedirect("user?action=create");
                }
            }
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
        return "User Controller";
    }
} 