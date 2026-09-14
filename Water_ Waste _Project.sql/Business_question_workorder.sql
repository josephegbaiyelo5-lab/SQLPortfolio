/* Which assets have the poorest reliability? */

   SELECT
    asset_id,
    COUNT(failure_code) AS failure_count,
    COALESCE(ROUND(AVG(downtime_hours) FILTER (WHERE status = 'closed'),2), 0) AS mttr_hours,
    ROUND(8760.0 / NULLIF(COUNT(failure_code), 0),2) AS mtbf_hours
FROM work_orders
GROUP BY asset_id
ORDER BY mtbf_hours ASC;
 