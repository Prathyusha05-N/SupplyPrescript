SELECT
    shipping_mode,
    COUNT(*) AS shipments,
    ROUND(AVG(late_delivery_risk) * 100, 2) AS late_delivery_rate
FROM supply_chain
GROUP BY shipping_mode
ORDER BY late_delivery_rate DESC;