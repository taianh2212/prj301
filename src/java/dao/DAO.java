/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import context.DBContext;
import entity.Account;
import entity.Category;
import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import entity.CartItem;
import entity.Order;
import entity.OrderItem;

/**
 *
 * @author trinh
 */
public class DAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from product";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> getTop3() {
        List<Product> list = new ArrayList<>();
        String query = "select top 3 * from product";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> getNext3Product(int amount) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT *\n"
                + "  FROM product\n"
                + " ORDER BY id\n"
                + "OFFSET ? ROWS\n"
                + " FETCH NEXT 3 ROWS ONLY";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, amount);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> getProductByCID(String cid) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where cateID = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> getProductBySellID(int id) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where sell_ID = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where [name] like ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Product getProductByID(String id) {
        String query = "select * from product\n"
                + "where id = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String query = "select * from Category";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Product getLast() {
        String query = "select top 1 * from product\n"
                + "order by id desc";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Account login(String user, String pass) {
        String query = "select * from account\n"
                + "where [user] = ?\n"
                + "and pass = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Account checkAccountExist(String user) {
        String query = "select * from account\n"
                + "where [user] = ?\n";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void singup(String user, String pass) {
        String query = "insert into account\n"
                + "values(?,?,0,0)";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteProduct(String pid) {
        String query = "delete from product\n"
                + "where id = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void insertProduct(String name, String image, String price,
            String title, String description, String category, int sid) {
        String query = "INSERT [dbo].[product] \n"
                + "([name], [image], [price], [title], [description], [cateID], [sell_ID])\n"
                + "VALUES(?,?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setInt(7, sid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void editProduct(String name, String image, String price,
            String title, String description, String category, String pid) {
        String query = "update product\n"
                + "set [name] = ?,\n"
                + "[image] = ?,\n"
                + "price = ?,\n"
                + "title = ?,\n"
                + "[description] = ?,\n"
                + "cateID = ?\n"
                + "where id = ?";
        try {
            conn = new DBContext().getConnection();//mo ket noi voi sql
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, category);
            ps.setString(7, pid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        String query = "select * from account";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)));
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public void deleteAccount(String id) {
        String query = "delete from account\n"
                + "where [id] = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public void updateAccount(String id, String username, String password, String isSell, String isAdmin) {
        String query = "update account\n"
                + "set [user] = ?,\n"
                + "[pass] = ?,\n"
                + "isSell = ?,\n"
                + "isAdmin = ?\n"
                + "where [id] = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, isSell);
            ps.setString(4, isAdmin);
            ps.setString(5, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public Account getAccountByID(String id) {
        String query = "select * from account\n"
                + "where id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5));
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public void insertAccount(String username, String password, String isSell, String isAdmin) {
        String query = "insert into account\n"
                + "values(?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, isSell);
            ps.setString(4, isAdmin);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public Account checkGoogleAccountExist(String email) {
        String query = "select * from Account\n"
                + "where [email] = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Account insertGoogleAccount(String email, String name) {
        String query = "INSERT INTO Account (username, [password], isSell, isAdmin, [email], [name]) "
                + "VALUES (?, ?, 0, 0, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            
            // Use email as username if needed
            ps.setString(1, email);
            
            // Generate a random password (won't be used for login since Google OAuth is used)
            String randomPass = generateRandomPassword();
            ps.setString(2, randomPass);
            
            // Set email and name from Google account
            ps.setString(3, email);
            ps.setString(4, name);
            
            ps.executeUpdate();
            
            // Return the newly created account
            return checkGoogleAccountExist(email);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private String generateRandomPassword() {
        // Generate a random password with 10 characters
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            int index = (int) (Math.random() * chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
    
    // Order-related methods
    
    public int createOrder(int accountId, double totalAmount, String paymentMethod, String transactionCode) {
        int orderId = -1;
        String orderCode = generateOrderCode();
        String query = "INSERT INTO Orders (account_id, order_code, total_amount, order_date, " +
                      "payment_method, transaction_code, status) " +
                      "VALUES (?, ?, ?, GETDATE(), ?, ?, 'Completed'); " +
                      "SELECT SCOPE_IDENTITY() AS order_id;";
        try {
            System.out.println("DEBUG createOrder - Starting with accountId: " + accountId 
                    + ", amount: " + totalAmount 
                    + ", orderCode: " + orderCode);
            System.out.println("DEBUG createOrder - Query: " + query);
            
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountId);
            ps.setString(2, orderCode);
            ps.setDouble(3, totalAmount);
            ps.setString(4, paymentMethod);
            ps.setString(5, transactionCode);
            
            System.out.println("DEBUG createOrder - Executing query...");
            rs = ps.executeQuery();
            
            if (rs.next()) {
                orderId = rs.getInt("order_id");
                System.out.println("DEBUG createOrder - Order created with ID: " + orderId);
            } else {
                System.out.println("DEBUG createOrder - No order ID returned from query");
            }
        } catch (Exception e) {
            System.out.println("ERROR in createOrder: " + e.getMessage());
            e.printStackTrace();
        }
        return orderId;
    }
    
    public void saveOrderItems(int orderId, List<CartItem> cartItems) {
        String query = "INSERT INTO OrderItems (order_id, product_id, product_name, price, quantity) " +
                      "VALUES (?, ?, ?, ?, ?)";
        try {
            System.out.println("DEBUG saveOrderItems - Starting for orderId: " + orderId + ", items: " + cartItems.size());
            
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            
            int count = 0;
            for (CartItem item : cartItems) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProduct().getId());
                ps.setString(3, item.getProduct().getName());
                ps.setDouble(4, item.getProduct().getPrice());
                ps.setInt(5, item.getQuantity());
                ps.addBatch();
                
                System.out.println("DEBUG saveOrderItems - Added item to batch: ProductID=" 
                    + item.getProduct().getId() 
                    + ", Name=" + item.getProduct().getName() 
                    + ", Qty=" + item.getQuantity()
                    + ", Price=" + item.getProduct().getPrice());
                count++;
            }
            
            System.out.println("DEBUG saveOrderItems - Executing batch for " + count + " items");
            int[] results = ps.executeBatch();
            System.out.println("DEBUG saveOrderItems - Batch execution complete, results length: " + results.length);
            
        } catch (Exception e) {
            System.out.println("ERROR in saveOrderItems: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public List<Order> getOrdersByAccountId(int accountId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE account_id = ? ORDER BY order_date DESC";
        try {
            System.out.println("DEBUG getOrdersByAccountId - Starting method with accountId: " + accountId);
            System.out.println("DEBUG getOrdersByAccountId - Query: " + query);
            
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, accountId);
            
            System.out.println("DEBUG getOrdersByAccountId - Executing query...");
            rs = ps.executeQuery();
            
            System.out.println("DEBUG getOrdersByAccountId - Query executed, processing results...");
            int count = 0;
            while (rs.next()) {
                count++;
                int id = rs.getInt("id");
                int dbAccountId = rs.getInt("account_id");
                String orderCode = rs.getString("order_code");
                double amount = rs.getDouble("total_amount");
                
                System.out.println("DEBUG getOrdersByAccountId - Found order: ID=" + id 
                    + ", AccID=" + dbAccountId 
                    + ", Code=" + orderCode 
                    + ", Amount=" + amount);
                
                Order order = new Order(
                    id,
                    dbAccountId,
                    orderCode,
                    amount,
                    rs.getTimestamp("order_date"),
                    rs.getString("payment_method"),
                    rs.getString("transaction_code"),
                    rs.getString("status")
                );
                
                // Load order items
                List<OrderItem> items = getOrderItemsByOrderId(order.getId());
                System.out.println("DEBUG getOrdersByAccountId - Found " + items.size() + " items for order " + id);
                order.setOrderItems(items);
                orders.add(order);
            }
            
            System.out.println("DEBUG getOrdersByAccountId - Total orders found: " + count);
        } catch (Exception e) {
            System.out.println("ERROR in getOrdersByAccountId: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }
    
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String query = "SELECT * FROM OrderItems WHERE order_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem(
                    rs.getInt("id"),
                    rs.getInt("order_id"),
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getDouble("price"),
                    rs.getInt("quantity")
                );
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }
    
    public Order getOrderById(int orderId) {
        Order order = null;
        String query = "SELECT * FROM Orders WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                order = new Order(
                    rs.getInt("id"),
                    rs.getInt("account_id"),
                    rs.getString("order_code"),
                    rs.getDouble("total_amount"),
                    rs.getTimestamp("order_date"),
                    rs.getString("payment_method"),
                    rs.getString("transaction_code"),
                    rs.getString("status")
                );
                
                // Load order items
                order.setOrderItems(getOrderItemsByOrderId(order.getId()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }
    
    private String generateOrderCode() {
        long timestamp = System.currentTimeMillis();
        int randomNum = (int) (Math.random() * 1000);
        return "ORD-" + timestamp + "-" + randomNum;
    }

    public static void main(String[] args) {
        DAO dao = new DAO();
        List<Product> list = dao.getAllProduct();
        List<Category> listC = dao.getAllCategory();

        for (Category o : listC) {
            System.out.println(o);
        }
    }
}
