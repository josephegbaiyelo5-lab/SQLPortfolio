/* which assets readings with historian source are suspicious */
SELECT
asset_id
source,
quality_flag
FROM meter_readings
WHERE source = 'Historian' AND quality_flag = 'Suspect'
GROUP BY asset_id, source, quality_flag;

-- what percentage of SCADA readings are good quality within each plant?
WITH reading_quality_ext AS (SELECT
    plant_id,
    quality_flag,
    COUNT(*) AS total_readings,
    COUNT(*) FILTER(WHERE source = 'SCADA') AS scada_readings
FROM meter_readings
GROUP BY plant_id, quality_flag
HAVING quality_flag = 'Good'
)
SELECT
plant_id,
total_readings,
scada_readings,
ROUND(scada_readings * 100.0 / total_readings, 2) AS scada_good_quality_percentage
FROM reading_quality_ext
GROUP BY plant_id, total_readings, scada_readings
ORDER BY scada_good_quality_percentage DESC;