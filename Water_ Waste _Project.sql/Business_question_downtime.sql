/* what percentage of downtime is caused by top 5 failure mechanisms? 
what percentage of downtime is caused by top 5 root causes? */

-- what percentage of downtime is caused by top 5 failure mechanisms?
SELECT
    failure_code,
    SUM(downtime_hours) AS total_downtime,
    ROUND((SUM(downtime_hours) / (SELECT SUM(downtime_hours) FROM work_orders)) * 100, 2) AS downtime_percentage
FROM work_orders
GROUP BY failure_code
ORDER BY total_downtime DESC
LIMIT 5;

-- what percentage of downtime is caused by top 5 root causes?
SELECT
    root_cause,
    SUM(downtime_hours) AS total_downtime,
    ROUND((SUM(downtime_hours) / (SELECT SUM(downtime_hours) FROM work_orders)) * 100, 2) AS downtime_percentage
FROM work_orders
GROUP BY root_cause
ORDER BY total_downtime DESC
LIMIT 5;

-- what percentage of downtime is caused by calibration drift ELEC failure mechanism for each plant?
SELECT
    plant_id,
    failure_code,
    root_cause,
    SUM(downtime_hours) AS total_downtime,
    ROUND((SUM(downtime_hours) / (SELECT SUM(downtime_hours) FROM work_orders)) * 100, 2) AS downtime_percentage
FROM work_orders
WHERE failure_code = 'ELEC' AND root_cause = 'Calibration drift'
GROUP BY plant_id, failure_code, root_cause
ORDER BY total_downtime DESC;