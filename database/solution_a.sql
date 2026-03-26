-- 1. Lấy ra danh sách người dùng theo thứ tự tên Alphabet (A->Z)
SELECT * FROM users 
ORDER BY user_name ASC;

-- 2. Lấy ra 07 người dùng theo thứ tự tên Alphabet (A->Z)
SELECT * FROM users 
ORDER BY user_name ASC 
LIMIT 7;

-- 3. Danh sách người dùng theo Alphabet (A->Z), tên có chứa chữ 'a'
SELECT * FROM users 
WHERE user_name LIKE '%a%' 
ORDER BY user_name ASC;

-- 4. Tìm người dùng có tên bắt đầu bằng chữ 'm'
SELECT * FROM users 
WHERE user_name LIKE 'm%';

-- 5. Tìm người dùng có tên kết thúc bằng chữ 'i'
SELECT * FROM users 
WHERE user_name LIKE '%i';

-- 6. Danh sách người dùng sử dụng email là Gmail (@gmail.com)
SELECT * FROM users 
WHERE user_email LIKE '%@gmail.com';

-- 7. Người dùng sử dụng Gmail VÀ tên bắt đầu bằng chữ 'm'
SELECT * FROM users 
WHERE user_email LIKE '%@gmail.com' 
AND user_name LIKE 'm%';

-- 8. Email là Gmail, tên có chữ 'i' và chiều dài tên lớn hơn 5 ký tự
SELECT * FROM users 
WHERE user_email LIKE '%@gmail.com' 
AND user_name LIKE '%i%' 
AND LENGTH(user_name) > 5;

-- 9. Tên có chữ 'a' (dài từ 5-9 ký tự), dùng Gmail, và phần tên email có chữ 'i'
SELECT * FROM users 
WHERE user_name LIKE '%a%' 
AND LENGTH(user_name) BETWEEN 5 AND 9 
AND user_email LIKE '%i%@gmail.com';

-- 10. Điều kiện kết hợp (HOẶC): 
-- (Tên có 'a' dài 5-9) HOẶC (Tên có 'i' dài < 9) HOẶC (Email Gmail có chữ 'i')
SELECT * FROM users 
WHERE (user_name LIKE '%a%' AND LENGTH(user_name) BETWEEN 5 AND 9)
   OR (user_name LIKE '%i%' AND LENGTH(user_name) < 9)
   OR (user_email LIKE '%i%@gmail.com');