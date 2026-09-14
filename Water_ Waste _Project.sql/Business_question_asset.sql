/* which assets have the poorest reliability performance relative to their 'critical' criticality? */
WITH asset_criticality_ext AS (
    SELECT
    a.asset_id,
    a.asset_criticality,
    COUNT(w.failure_code) AS total_failures,
    SUM(w.downtime_hours) AS total_downtime
    FROM work_orders w
    JOIN assets a ON w.asset_id = a.asset_id
    GROUP BY a.asset_id, a.asset_criticality
)
SELECT
    asset_id,
    asset_criticality,
    ROUND(AVG(total_failures), 2) AS avg_failures,
    ROUND(AVG(total_downtime), 2) AS avg_downtime
FROM asset_criticality_ext
GROUP BY asset_id, asset_criticality
HAVING asset_criticality ='Critical'
ORDER BY avg_failures DESC, avg_downtime DESC;