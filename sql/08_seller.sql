-- Sebaran seller per negara bagian
SELECT
    seller_state,
    COUNT(*) AS jumlah_seller,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS persen_seller
FROM sellers
GROUP BY seller_state
ORDER BY jumlah_seller DESC;

-- 10 seller dengan revenue tertinggi (hanya order delivered)
SELECT
    RANK() OVER (ORDER BY SUM(oi.price) DESC) AS peringkat,
    oi.seller_id,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS jumlah_order,
    SUM(oi.price) AS revenue,
    ROUND(SUM(oi.price) * 100.0 / SUM(SUM(oi.price)) OVER (), 2) AS persen_revenue
FROM order_items oi
JOIN orders o  ON oi.order_id = o.order_id
JOIN sellers s ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id, s.seller_state
ORDER BY peringkat
LIMIT 10;
