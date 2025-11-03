WITH statistic_events AS (
    SELECT
        event_type_main,
        SUM(revenue) AS total_revenue,
        COUNT(order_id) AS total_orders,
        AVG(revenue) AS avg_revenue_per_order,
        COUNT(DISTINCT event_name_code) AS total_event_name,
        SUM(tickets_count) AS total_tickets
    FROM afisha.purchases
    JOIN afisha.events USING(event_id)
    WHERE currency_code = 'rub'
    GROUP BY event_type_main
),
all_revenue AS (
    SELECT
        SUM(revenue) AS all_revenue,
        SUM(tickets_count) AS all_tickets
    FROM afisha.purchases
    WHERE currency_code = 'rub'
)
SELECT 
    event_type_main,
    total_revenue,
    total_orders,
    avg_revenue_per_order,
    total_event_name,
    total_tickets::numeric / total_orders::numeric AS avg_tickets,
    total_revenue/ total_tickets AS avg_ticket_revenue,
    ROUND(total_revenue::numeric / all_revenue::numeric, 3) AS revenue_share
FROM statistic_events
CROSS JOIN all_revenue
ORDER BY total_orders DESC;
