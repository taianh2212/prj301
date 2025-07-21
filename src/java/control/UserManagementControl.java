package control;

import dao.DAO;
import entity.Account;
import java.io.IOException;
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
@WebServlet(name = "UserManagementControl", urlPatterns = {"/user-management"})
public class UserManagementControl extends HttpServlet {

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
            request.setAttribute("accounts", dao.getAllAccounts());
            request.getRequestDispatcher("admin/users.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            // Delete user
            String userId = request.getParameter("id");
            if (userId != null && !userId.equals(String.valueOf(account.getId()))) {
                dao.deleteAccount(userId);
            }
            response.sendRedirect("user-management");
        } else if (action.equals("edit")) {
            // Show edit form for a user
            String userId = request.getParameter("id");
            Account userToEdit = dao.getAccountByID(userId);
            request.setAttribute("userToEdit", userToEdit);
            request.getRequestDispatcher("admin/editUser.jsp").forward(request, response);
        } else if (action.equals("update")) {
            // Update user details
            String id = request.getParameter("id");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String isSell = request.getParameter("isSell");
            String isAdmin = request.getParameter("isAdmin");
            
            if (id != null && username != null && password != null) {
                dao.updateAccount(id, username, password, isSell, isAdmin);
            }
            response.sendRedirect("user-management");
        } else if (action.equals("add")) {
            // Show add user form
            request.getRequestDispatcher("admin/addUser.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Create new user
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String isSell = request.getParameter("isSell");
            String isAdmin = request.getParameter("isAdmin");
            
            if (username != null && password != null) {
                Account existingAccount = dao.checkAccountExist(username);
                if (existingAccount == null) {
                    dao.insertAccount(username, password, isSell, isAdmin);
                    response.sendRedirect("user-management");
                } else {
                    request.setAttribute("error", "Username already exists");
                    request.setAttribute("username", username);
                    request.getRequestDispatcher("admin/addUser.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("user-management?action=add");
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
        return "User Management Controller";
    }
} 