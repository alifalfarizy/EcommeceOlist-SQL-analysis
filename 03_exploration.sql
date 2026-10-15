-- Rentang waktu data
SELECT
    MIN(order_purchase_timestamp) AS order_pertama,
    MAX(order_purchase_timestamp) AS order_terakhir
FROM orders;

-- Jumlah order per bulan
SELECT
    DATE_TRUNC('month', order_purchase_timestamp)::date AS bulan,
    COUNT(*) AS jumlah_order
FROM orders
GROUP BY 1
ORDER BY 1;

-- Gambaran revenue, hanya order delivered
SELECT
    COUNT(DISTINCT o.order_id)       AS jumlah_order,
    SUM(oi.price)                    AS revenue_produk,
    SUM(oi.freight_value)            AS total_ongkir,
    SUM(oi.price + oi.freight_value) AS total_bayar
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';
