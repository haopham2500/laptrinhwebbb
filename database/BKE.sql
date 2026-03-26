-- Kiểm tra và tạo Cơ sở dữ liệu (tùy chọn)
-- CREATE DATABASE IF NOT EXISTS ban_hang;
-- USE ban_hang;

-- 1. Tạo bảng Parent 1: users 
CREATE TABLE users (
    user_id INT(11) NOT NULL AUTO_INCREMENT, -- Mã số user, AI, Not NULL
    user_name VARCHAR(25) NOT NULL,        -- Tên user, VARCHAR(25), Not NULL
    user_email VARCHAR(55) NOT NULL,       -- Email, VARCHAR(55), Not NULL
    user_pass VARCHAR(255) NOT NULL,      -- Mật khẩu, VARCHAR(255), Not NULL (VARCHAR 255 phù hợp lưu hash password)
    updated_at DATETIME DEFAULT NULL,      -- Thời gian cập nhật, cho phép NULL
    created_at DATETIME DEFAULT NULL,      -- Thời gian tạo, cho phép NULL
    PRIMARY KEY (user_id)                  -- Khóa chính
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 2. Tạo bảng Parent 2: products 
CREATE TABLE products (
    product_id INT(11) NOT NULL AUTO_INCREMENT, -- Mã số sản phẩm, AI, Not NULL
    product_name VARCHAR(255) NOT NULL,       -- Tên sản phẩm, VARCHAR(255), Not NULL
    product_price DOUBLE NOT NULL,            -- Giá sản phẩm, DOUBLE, Not NULL (Kiểu số thực)
    product_description TEXT NOT NULL,        -- Mô tả sản phẩm, TEXT, Not NULL
    updated_at DATETIME DEFAULT NULL,          -- Thời gian cập nhật, cho phép NULL
    created_at DATETIME DEFAULT NULL,          -- Thời gian tạo, cho phép NULL
    PRIMARY KEY (product_id)                 -- Khóa chính
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tạo bảng Child 1: orders 
CREATE TABLE orders (
    order_id INT(11) NOT NULL AUTO_INCREMENT,  -- Mã số đơn hàng, AI, Not NULL
    user_id INT(11) NOT NULL,                  -- Mã user, Not NULL
    updated_at DATETIME DEFAULT NULL,           -- Thời gian cập nhật, cho phép NULL
    created_at DATETIME DEFAULT NULL,           -- Thời gian tạo, cho phép NULL
    PRIMARY KEY (order_id),                    -- Khóa chính
    -- Thêm Khóa ngoại contextually tham chiếu đến bảng users
    CONSTRAINT fk_orders_users FOREIGN KEY (user_id) REFERENCES users(user_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tạo bảng Child 2: order_details 
CREATE TABLE order_details (
    order_detail_id INT(11) NOT NULL AUTO_INCREMENT, -- Mã số chi tiết đơn hàng, AI, Not NULL
    order_id INT(11) NOT NULL,                       -- Mã số đơn hàng, Not NULL
    product_id INT(11) NOT NULL,                     -- Mã số sản phẩm, Not NULL
    updated_at DATETIME DEFAULT NULL,                 -- Thời gian cập nhật, cho phép NULL
    created_at DATETIME DEFAULT NULL,                 -- Thời gian tạo, cho phép NULL
    PRIMARY KEY (order_detail_id),                   -- Khóa chính
    -- Thêm Khóa ngoại contextually tham chiếu đến bảng orders
    CONSTRAINT fk_details_orders FOREIGN KEY (order_id) REFERENCES orders(order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    -- Thêm Khóa ngoại contextually tham chiếu đến bảng products
    CONSTRAINT fk_details_products FOREIGN KEY (product_id) REFERENCES products(product_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
