-- Ringkasan pengiriman. Dibandingkan per tanggal
SELECT
    COUNT(*) AS jumlah_order,
    ROUND(AVG(order_delivered_customer_date::date - order_purchase_timestamp::date), 1) AS rata_hari_kirim,
    ROUND(AVG(order_estimated_delivery_date::date - order_purchase_timestamp::date), 1) AS rata_hari_estimasi,
    COUNT(*) FILTER (WHERE order_delivered_customer_date::date > order_estimated_delivery_date::date) AS jumlah_telat,
    ROUND(COUNT(*) FILTER (WHERE order_delivered_customer_date::date > order_estimated_delivery_date::date) * 100.0 / COUNT(*), 1) AS persen_telat
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;

-- Rata-rata hari kirim per negara bagian customer
-- Baca bersama jumlah_order, karena rata-rata dari order sedikit kurang stabil
SELECT
    c.customer_state,
    COUNT(*) AS jumlah_order,
    ROUND(AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date), 1) AS rata_hari_kirim
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY rata_hari_kirim DESC;
