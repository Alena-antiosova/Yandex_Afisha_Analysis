SELECT 
    date_trunc('week', created_ts_msk)::date AS week,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT user_id) AS total_users,
    SUM(revenue)/COUNT(order_id) as revenue_per_order
FROM afisha.purchases
WHERE currency_code = 'rub'
GROUP BY date_trunc('week', created_ts_msk)::date
ORDER BY week;

