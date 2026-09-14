/*Which plants have the highest regulatory risk?
Which plants have the highest regulatory inspections failed percentage? */

-- which plants have the highest regulatory risk
SELECT
    plant_id,
    COUNT(*) AS high_risk_findings
FROM inspections
WHERE inspection_type = 'Regulatory'
  AND result = 'Fail'
  AND severity = 'High'
GROUP BY plant_id
ORDER BY high_risk_findings DESC;

-- what is the percentage of failed regulatory inspections for each plant?
SELECT
    plant_id,
    COUNT(*) AS total_inspections,
    SUM(CASE WHEN result = 'Fail' THEN 1 ELSE 0 END) AS failed_inspections,
    ROUND((SUM(CASE WHEN result = 'Fail' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS failure_percentage
FROM inspections
WHERE inspection_type = 'Regulatory'
GROUP BY plant_id
ORDER BY failure_percentage DESC;

--which plants have the highest regulatory inspections failed percentage?
SELECT
    plant_id,
    COUNT(*) AS high_regulatory_inspections,
    COUNT(*) FILTER (WHERE result = 'Fail') AS failed_inspections,
    ROUND(COUNT(*) FILTER (WHERE result = 'Fail') * 100.0/ NULLIF(COUNT(*), 0),2) AS failure_rate_percent
FROM inspections
WHERE inspection_type = 'Regulatory' AND severity = 'High'
GROUP BY plant_id
ORDER BY failure_rate_percent DESC;

