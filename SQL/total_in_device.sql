-- Настройка параметра synchronize_seqscans важна для проверки
WITH set_config_precode AS (
  SELECT set_config('synchronize_seqscans', 'off', true)
),
statistic as (
    select   
    device_type_canonical,
    sum(revenue) as total_revenue,
    count(order_id) as total_orders,
    avg(revenue) as avg_revenue_per_order 
    from afisha.purchases
    Where currency_code = 'rub'
    Group by device_type_canonical
),

statistic_revenue as (
    select
    sum(revenue) as all_revenue
    from afisha.purchases
    Where currency_code = 'rub'
)

SELECT
device_type_canonical,
total_revenue,
total_orders,
avg_revenue_per_order,
round((total_revenue::numeric / all_revenue::numeric), 3) as revenue_share
from statistic 
join statistic_revenue on 1=1
order by revenue_share desc