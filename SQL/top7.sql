select 
region_name,
SUM(revenue) AS total_revenue,
COUNT(order_id) AS total_orders,
COUNT(DISTINCT user_id) AS total_users,
SUM(tickets_count) AS total_tickets,
SUM(revenue)/SUM(tickets_count) as one_ticket_cost
from afisha.purchases
join afisha.events using(event_id)
join afisha.city using(city_id)
join afisha.regions using(region_id)
WHERE currency_code = 'rub'
Group by region_name
Order by total_revenue desc
limit 7

