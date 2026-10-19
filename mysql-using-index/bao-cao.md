# Báo cáo thực hành: Sử dụng INDEX trong MySQL

## 1. Mục tiêu
Sử dụng cơ sở dữ liệu `classicmodels`, truy vấn `customers` trước/sau khi thêm index, kiểm tra index ghép và xóa index.

## 2. Môi trường
- Hệ quản trị: MySQL [điền phiên bản]
- Công cụ: [MySQL Workbench / mysql CLI]
- Số dòng bảng `customers`: [điền từ SELECT COUNT(*)]
- Ngày thực hành: [điền]

## 3. Kết quả thực tế (chạy SQL rồi điền)
| Truy vấn | Trạng thái | type | possible_keys | key | rows (ước lượng) | thời gian thực thi |
|---|---|---|---|---|---|---|
| customerName = 'Land of Toys Inc.' | Trước index | ... | ... | ... | ... | ... |
| customerName = 'Land of Toys Inc.' | Sau idx_customerName | ... | ... | ... | ... | ... |
| contactFirstName = 'Jean' OR 'King' | Sau idx_full_name | ... | ... | ... | ... | ... |
| contactFirstName = 'Jean' OR 'King' | Sau xóa idx_full_name | ... | ... | ... | ... | ... |

*Lưu ý:* `EXPLAIN` thông thường cho biết kế hoạch thực thi chứ không đo thời gian. Ghi thời gian từ `EXPLAIN ANALYZE` (MySQL 8.0.18+) hoặc công cụ đo thực tế. Chưa có kết quả nào được giả định sẵn.

## 4. Nhận xét gợi ý (chỉnh theo output thực tế)
- Trước index, MySQL có thể chọn `type=ALL` nếu không có index phù hợp.
- Sau index đơn, `possible_keys` có thể chứa `idx_customerName`; `key` chỉ xuất hiện khi optimizer thực sự dùng index.
- Index ghép hỗ trợ điều kiện trên cột đầu và cả cặp cột theo thứ tự khai báo; điều kiện chỉ dùng cột thứ hai có thể không tận dụng được index này.
- `classicmodels` mẫu ít bản ghi, nên chưa thể khẳng định index luôn làm truy vấn nhanh hơn. Index tiêu tốn dung lượng và có thể tăng chi phí ghi dữ liệu.

## 5. Ảnh minh chứng cần chụp
1. Kết quả COUNT(*) và EXPLAIN trước index.
2. SHOW INDEX và EXPLAIN sau khi tạo idx_customerName.
3. SHOW INDEX / EXPLAIN sau khi tạo idx_full_name.
4. SHOW INDEX / EXPLAIN sau khi xóa idx_full_name.

## 6. Kết luận
[Viết kết luận dựa trên kế hoạch EXPLAIN và số liệu thời gian đo được, không dùng kết quả giả.]
