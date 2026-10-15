-- Jumlah baris per tabel
SELECT 'customers' AS tabel, COUNT(*) AS jumlah_baris FROM customers
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL SELECT 'product_category_translation', COUNT(*) FROM product_category_translation;

-- Sebaran status order
SELECT order_status, COUNT(*) AS jumlah
FROM orders
GROUP BY order_status
ORDER BY jumlah DESC;

-- Jumlah tanggal kosong di tabel orders
SELECT
    COUNT(*) AS total_order,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS approved_null,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS carrier_null,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS delivered_null
FROM orders;

-- Order berstatus delivered tapi tanpa tanggal sampai
SELECT COUNT(*) AS delivered_tapi_tanpa_tanggal
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;

-- Order yang sampai sebelum tanggal pembelian
SELECT COUNT(*) AS kirim_sebelum_beli
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;
