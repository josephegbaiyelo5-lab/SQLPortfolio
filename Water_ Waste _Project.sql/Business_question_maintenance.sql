/* Do assets receiving more preventive maintenance experience fewer failures?
Are assets with high preventive-maintenance coverage experiencing fewer failures?
Which plant has the highest maintenance cost within each region?
Did maintenance expenditure increase or decrease compared with the previous month? 
*/


-- Which plant has the highest maintenance cost within each region?
-- key words - each region, which plant - plant name, highest maintenace cost - total cost with each region
WITH plant_cost AS (
    SELECT
        p.region,
        p.plant_name,
        SUM(w.total_cost) AS maintenance_cost
    FROM work_orders AS w
    LEFT JOIN plants AS p
        ON w.plant_id = p.plant_id
    GROUP BY
        p.region,
        p.plant_name
)
SELECT
    region,
    plant_name,
    ROUND(maintenance_cost, 2) AS maintenance_cost,
    RANK() OVER (PARTITION BY region ORDER BY maintenance_cost DESC) AS regional_rank
FROM plant_cost
ORDER BY
    region,
    regional_rank;

-- Did maintenance expenditure increase or decrease compared with the previous month?
-- Key words - compared with previous month, increase or decrease maintenance expenditure
WITH monthly_exp AS (
    SELECT
        DATE_TRUNC('month', reported_date) AS month,
        SUM(total_cost) AS monthly_cost
    FROM work_orders
    WHERE reported_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', reported_date)
)
SELECT
    month,
    ROUND(monthly_cost, 2) AS monthly_cost,
    ROUND(LAG(monthly_cost) OVER (ORDER BY month),2) AS previous_month_cost,
    ROUND(100.0 *(monthly_cost - LAG(monthly_cost) OVER (ORDER BY month))/ NULLIF(LAG(monthly_cost) OVER (ORDER BY month),0),2
    ) AS month_on_month_pct_change
FROM monthly_exp
ORDER BY month;

--  Do assets receiving more preventive maintenance experience fewer failures?
-- Key words - assets, more, preventive maintenace, fewer failures
WITH asset_maintenance AS (
    SELECT
        asset_id,
        COUNT(*) AS total_work_orders,
        COUNT(*) FILTER (WHERE maintenance_type = 'Preventive') AS preventive_work_orders,
        COUNT(*) FILTER (WHERE maintenance_type = 'Corrective') AS corrective_work_orders,
        COUNT(failure_code) AS failure_work_orders
FROM work_orders
GROUP BY asset_id
)

SELECT
    asset_id,
    total_work_orders,
    preventive_work_orders,
    corrective_work_orders,
    failure_work_orders,
ROUND(preventive_work_orders * 100.0/ NULLIF(total_work_orders, 0),2) AS preventive_percentage,
ROUND(failure_work_orders * 100.0/ NULLIF(total_work_orders, 0),2) AS failure_percentage
FROM asset_maintenance
ORDER BY preventive_percentage DESC;

-- Are assets with high preventive-maintenance coverage experiencing fewer failures?
-- Key words - assets, high preventive maintenance coverage, fewer failures, preventive maintenance coverage - preventive percentage, fewer failures - failure percentage

WITH asset_maintenance AS (
    SELECT
        asset_id,
        COUNT(*) AS total_work_orders,
        COUNT(*) FILTER (WHERE maintenance_type = 'Preventive') AS preventive_work_orders,
        COUNT(failure_code) AS failure_work_orders,
        SUM(downtime_hours) AS total_downtime
        FROM work_orders
    GROUP BY asset_id
),
asset_preventive AS (
    SELECT
    asset_id,
    total_work_orders,
    preventive_work_orders,
    failure_work_orders,
    total_downtime,
ROUND(preventive_work_orders * 100.0/ NULLIF(total_work_orders, 0),2) AS preventive_percentage,
ROUND(failure_work_orders * 100.0/ NULLIF(total_work_orders, 0),2) AS failure_percentage
FROM asset_maintenance
),
maintenance_groups AS (
    SELECT
    asset_id,
    preventive_percentage,
    failure_percentage,
    total_downtime,
    CASE
        WHEN preventive_work_orders * 100.0
             / NULLIF(total_work_orders, 0) >= 70
            THEN 'High Preventive'
        WHEN preventive_work_orders * 100.0
             / NULLIF(total_work_orders, 0) >= 40
            THEN 'Medium Preventive'
        ELSE 'Low Preventive'
    END AS preventive_group
FROM asset_preventive
)
SELECT
    preventive_group,
    ROUND(AVG(failure_percentage), 2) AS avg_failure_Percentage,
    ROUND(AVG(preventive_percentage), 2) AS avg_preventive_Percentage,
    ROUND(AVG(total_downtime), 2) AS avg_downtime_hours,
    COUNT(*) AS assets
FROM maintenance_groups
GROUP BY preventive_group
ORDER BY avg_failure_Percentage;


