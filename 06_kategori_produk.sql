-- 10 kategori produk dengan revenue tertinggi (hanya order delivered)
-- LEFT JOIN ke tabel terjemahan supaya produk tanpa terjemahan tidak hilang
SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name,
             'tanpa_kategori')                  AS kategori,
    COUNT(DISTINCT oi.order_id)                 AS jumlah_order,
    SUM(oi.price)                               AS revenue,
    ROUND(SUM(oi.price) * 100.0
          / SUM(SUM(oi.price)) OVER (), 1)      AS persen_revenue
FROM order_items oi
JOIN orders o   ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation t
       ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY revenue DESC
LIMIT 10;
