-- Revenue bulanan dan pertumbuhan bulan ke bulan (MoM)
-- Periode Jan 2017 sampai Agu 2018, karena bulan lain datanya terlalu sedikit
WITH revenue_bulanan AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp)::date AS bulan,
        COUNT(DISTINCT o.order_id) AS jumlah_order,
        SUM(oi.price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp <  '2018-09-01'
    GROUP BY 1
)
SELECT
    bulan,
    jumlah_order,
    revenue,
    LAG(revenue) OVER (ORDER BY bulan) AS revenue_bulan_lalu,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY bulan))
        / LAG(revenue) OVER (ORDER BY bulan) * 100
    , 1) AS mom_persen
FROM revenue_bulanan
ORDER BY bulan;
