/*Which vendors have the poorest delivery performance based on late-delivery frequency, average delay days, and maximum delay? */

SELECT
    vendor_id,
    COUNT(*) AS total_pos,
    COUNT(*) FILTER (WHERE received_date > promised_date) AS late_pos,
    ROUND(COUNT(*) FILTER (WHERE received_date > promised_date) * 100.0 / NULLIF(COUNT(*), 0),2) AS late_delivery_percentage,
    ROUND(AVG(CASE WHEN received_date > promised_date THEN received_date - promised_date ELSE NULL END), 2) AS avg_delay_days,
    MAX(CASE WHEN received_date > promised_date THEN received_date - promised_date ELSE NULL END) AS max_delay_days,
        CASE
        WHEN AVG(CASE WHEN received_date > promised_date THEN received_date - promised_date ELSE NULL END) > 0 THEN 'Poor'
                WHEN AVG(CASE WHEN received_date = promised_date THEN 0 ELSE NULL END) = 0 THEN 'On Time'
                ELSE 'Early'
            END AS delivery_performance
FROM purchase_orders
WHERE received_date IS NOT NULL
  AND promised_date IS NOT NULL
GROUP BY vendor_id
ORDER BY late_delivery_percentage DESC, avg_delay_days DESC, max_delay_days DESC
LIMIT 20;
