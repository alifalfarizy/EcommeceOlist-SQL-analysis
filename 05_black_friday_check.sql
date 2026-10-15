-- Lima hari dengan order terbanyak di November 2017, check blackfriday juga di November 2017
SELECT
    order_purchase_timestamp::date AS tanggal,
    COUNT(*) AS jumlah_order
FROM orders
WHERE order_purchase_timestamp >= '2017-11-01'
  AND order_purchase_timestamp <  '2017-12-01'
GROUP BY 1
ORDER BY jumlah_order DESC
LIMIT 5;
