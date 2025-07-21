-- Kiểm tra cấu trúc bảng Account
PRINT 'Checking Account table structure...';
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Account';

-- Kiểm tra và xóa bảng nếu đã tồn tại để tránh lỗi
IF OBJECT_ID('OrderItems', 'U') IS NOT NULL
    DROP TABLE OrderItems;

IF OBJECT_ID('Orders', 'U') IS NOT NULL
    DROP TABLE Orders;

-- Create Orders table
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    account_id INT NOT NULL,
    order_code VARCHAR(50) NOT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    payment_method VARCHAR(50) NOT NULL,
    transaction_code VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Completed',
    CONSTRAINT FK_Orders_Account FOREIGN KEY (account_id) REFERENCES Account(uID)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name NVARCHAR(255) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_id) REFERENCES Orders(id),
    CONSTRAINT FK_OrderItems_Product FOREIGN KEY (product_id) REFERENCES Product(id)
);

-- Create index for faster lookups
CREATE INDEX IDX_Orders_AccountId ON Orders(account_id);
CREATE INDEX IDX_OrderItems_OrderId ON OrderItems(order_id); 