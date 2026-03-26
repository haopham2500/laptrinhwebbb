-- 1. Liệt kê mã user, tên user, mã hóa đơn (Kết nối bảng users và orders)
SELECT u.user_id, u.user_name, o.order_id 
FROM users u 
JOIN orders o ON u.user_id = o.user_id;

-- 2. Đếm số lượng hóa đơn của mỗi khách hàng (Hiển thị tên và số lượng)
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS so_don_hang 
FROM users u 
LEFT JOIN orders o ON u.user_id = o.user_id 
GROUP BY u.user_id, u.user_name;

-- 3. Thông tin chi tiết mỗi hóa đơn: mã đơn hàng và tổng số sản phẩm trong đơn đó
SELECT order_id, COUNT(product_id) AS so_san_pham 
FROM order_details 
GROUP BY order_id;

-- 4. Thông tin mua hàng chi tiết: Tên user, mã đơn, tên sản phẩm đã mua
SELECT u.user_name, o.order_id, p.product_name 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
JOIN order_details od ON o.order_id = od.order_id 
JOIN products p ON od.product_id = p.product_id;

-- 5. Top 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS so_luong_don 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
GROUP BY u.user_id 
ORDER BY so_luong_don DESC 
LIMIT 7;

-- 6. Danh sách 7 người dùng đã từng mua sản phẩm của hãng 'Samsung' hoặc 'Apple'
SELECT DISTINCT u.user_id, u.user_name 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
JOIN order_details od ON o.order_id = od.order_id 
JOIN products p ON od.product_id = p.product_id 
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%' 
LIMIT 7;

-- 7. Tổng tiền của mỗi đơn hàng theo từng user (Tính bằng cách SUM giá sản phẩm)
SELECT u.user_name, o.order_id, SUM(p.product_price) AS tong_tien_don_hang 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
JOIN order_details od ON o.order_id = od.order_id 
JOIN products p ON od.product_id = p.product_id 
GROUP BY o.order_id;

-- 8. Đơn hàng có giá tiền LỚN NHẤT của mỗi người dùng
SELECT user_name, MAX(tong_tien) AS don_hang_dat_nhat
FROM (
    SELECT u.user_name, o.order_id, SUM(p.product_price) AS tong_tien 
    FROM users u 
    JOIN orders o ON u.user_id = o.user_id 
    JOIN order_details od ON o.order_id = od.order_id 
    JOIN products p ON od.product_id = p.product_id 
    GROUP BY o.order_id
) AS subquery 
GROUP BY user_name;

-- 9. Đơn hàng có giá tiền NHỎ NHẤT của mỗi user, kèm theo số lượng sản phẩm trong đơn đó
SELECT user_name, MIN(tong_tien) AS don_hang_re_nhat, so_luong_sp
FROM (
    SELECT u.user_name, o.order_id, SUM(p.product_price) AS tong_tien, COUNT(od.product_id) AS so_luong_sp 
    FROM users u 
    JOIN orders o ON u.user_id = o.user_id 
    JOIN order_details od ON o.order_id = od.order_id 
    JOIN products p ON od.product_id = p.product_id 
    GROUP BY o.order_id
) AS subquery 
GROUP BY user_name;

-- 10. Đơn hàng có NHIỀU sản phẩm nhất của mỗi user, kèm tổng tiền đơn đó
SELECT user_name, MAX(so_luong_sp) AS max_san_pham, tong_tien
FROM (
    SELECT u.user_name, o.order_id, COUNT(od.product_id) AS so_luong_sp, SUM(p.product_price) AS tong_tien 
    FROM users u 
    JOIN orders o ON u.user_id = o.user_id 
    JOIN order_details od ON o.order_id = od.order_id 
    JOIN products p ON od.product_id = p.product_id 
    GROUP BY o.order_id
) AS subquery 
GROUP BY user_name;