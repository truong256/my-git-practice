# Bài thực hành MySQL: Sử dụng INDEX

## Mục tiêu
Thực hành tạo, kiểm tra và xóa chỉ mục trên bảng `customers` của cơ sở dữ liệu mẫu **classicmodels**, quan sát kế hoạch thực thi trước/sau với `EXPLAIN` và so sánh tốc độ nếu có MySQL 8.0.18+.

## Chuẩn bị
- MySQL Server và MySQL Workbench hoặc MySQL CLI.
- Tải **classicmodels**: https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/
- Giải nén, import tệp `mysqlsampledatabase.sql` vào MySQL. Lưu ý file mẫu có lệnh tạo database và có thể ghi lại các bảng; không import đè lên dữ liệu cần giữ.
- Trong terminal MySQL: `source C:/duong-dan/mysqlsampledatabase.sql`; hoặc mở file trong Workbench và chạy toàn bộ.
- Kiểm tra: `USE classicmodels; SELECT COUNT(*) FROM customers;`.

## Thực hiện
1. Mở **[index.sql](index.sql)**, chọn database `classicmodels`, chạy lệnh theo thứ tự, từng khối.
2. Lưu kết quả `EXPLAIN` của truy vấn `customerName` trước khi có index.
3. Chạy `ALTER TABLE customers ADD INDEX idx_customerName(customerName);` và `EXPLAIN` lại. So sánh `type`, `possible_keys`, `key`, `rows`.
4. Tạo index ghép `(contactFirstName, contactLastName)`, chạy `EXPLAIN` với điều kiện OR, AND và thử truy vấn chỉ trên cột thứ hai.
5. Xóa index ghép `idx_full_name`, kiểm tra `SHOW INDEX` và `EXPLAIN` lại.
6. Điền kết quả đo thật của môi trường vào **[bao-cao.md](bao-cao.md)** rồi chụp các ảnh kết quả Workbench nếu giáo viên yêu cầu.

## Ý nghĩa các cột EXPLAIN
- `type=ALL`: thường là quét toàn bảng; `ref`: tra cứu với chỉ mục không duy nhất.
- `possible_keys`: index có thể cân nhắc; `key`: index thực sự được chọn; `NULL` nghĩa là không dùng index truy cập.
- `rows`: số dòng MySQL **ước lượng** cần xem xét, không phải số bản ghi trả về hoặc số dòng đã đọc thực tế.
- `key_len`: số byte tối đa dùng trong key truy cập, tùy charset/nullability.
- Index ghép tuân theo nguyên tắc **leftmost prefix**; hiệu quả phụ thuộc điều kiện lọc và trình tối ưu.
- Dataset `classicmodels` gốc nhỏ nên optimizer có thể chọn quét bảng dù đã tạo index. Điều này bình thường. Không kết luận tốc độ nhanh hơn chỉ từ `rows`; để đo thời gian sử dụng `EXPLAIN ANALYZE` (MySQL 8.0.18+) hoặc benchmark nhiều lần trên dataset lớn.

## Lưu ý
Chạy lại script nguyên bản khi index đã tồn tại sẽ báo lỗi trùng tên index. Hãy xóa index đã tạo trước khi chạy lại. Script không chứa mật khẩu hay thiết lập tài khoản.

## Tài liệu
- Database mẫu: https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/
- Tham khảo CodeGym (nhánh dev): https://github.com/codegym-vn/jwbd-2023-using-index/tree/dev
