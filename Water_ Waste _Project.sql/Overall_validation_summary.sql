/* create validation summary for all 4 validations - row counts, duplicates, nulls and relationships */


SELECT 
'plants' AS table_name, 
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM plants
    UNION ALL
    SELECT 
    'vendors' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM vendors
    UNION ALL
    SELECT 
    'assets' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM assets
    UNION ALL
    SELECT 
    'inventory' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM inventory
    UNION ALL
    SELECT 
    'work_orders' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM work_orders
    UNION ALL
    SELECT
    'inspections' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM inspections
    UNION ALL
    SELECT
    'meter_readings' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM meter_readings
    UNION ALL
    SELECT
    'purchase_orders' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM purchase_orders
    UNION ALL
    SELECT
    'financial_transactions' AS table_name,
    COUNT(*) AS row_count,
    CASE
    WHEN COUNT(*) > 0 THEN 'Pass'
    ELSE 'Fail'
    END AS row_count_validation
    FROM financial_transactions;

SELECT 
'plants' AS table_name,
COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT plant_id
    FROM plants
GROUP BY plant_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'vendors' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT vendor_id
    FROM vendors
GROUP BY vendor_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'assets' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT asset_id
    FROM assets
GROUP BY asset_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'inventory' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT inventory_id
    FROM inventory
GROUP BY inventory_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'work_orders' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT work_order_id
    FROM work_orders
GROUP BY work_order_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'inspections' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT inspection_id
    FROM inspections
GROUP BY inspection_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'meter_readings' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT reading_id
    FROM meter_readings
GROUP BY reading_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'purchase_orders' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT po_id
    FROM purchase_orders
GROUP BY po_id
HAVING COUNT(*) > 1) AS duplicates
UNION ALL
SELECT 'financial_transactions' AS table_name, COUNT(*) AS duplicate_groups,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT transaction_id
    FROM financial_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1) AS duplicates;

SELECT 
'plants' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT *
FROM plants
WHERE plant_id IS NULL
   OR plant_name IS NULL
   OR region IS NULL
   OR treatment_type IS NULL
   OR capacity_mld IS NULL
   OR commissioned_year IS NULL
   OR regulator IS NULL) AS null_checks
UNION ALL
SELECT 
'vendors' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT *
FROM vendors
WHERE vendor_id IS NULL
   OR vendor_name IS NULL
   OR vendor_category IS NULL
   OR country IS NULL
   OR payment_terms_days IS NULL
   OR approved_supplier IS NULL
   OR quality_rating IS NULL) AS null_checks
UNION ALL
SELECT 
'assets' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT *
FROM assets
WHERE asset_id IS NULL
   OR plant_id IS NULL
   OR asset_type IS NULL
   OR asset_criticality IS NULL
   OR manufacturer IS NULL
   OR install_date IS NULL
   OR status IS NULL
   OR rated_capacity IS NULL
   OR energy_class IS NULL) AS null_checks
UNION ALL
SELECT 
'inventory' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
 SELECT *
 FROM inventory
 WHERE inventory_id IS NULL
 OR plant_id IS NULL
 OR part_number IS NULL
 OR part_description IS NULL
 OR category IS NULL
 OR unit is NULL
 OR current_stock IS NULL
 OR reorder_point IS NULL
 OR safety_stock IS NULL
 OR unit_cost IS NULL
 OR preferred_vendor_id IS NULL
 OR stock_value IS NULL) AS null_checks
UNION ALL
 SELECT 
'work_orders' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
 SELECT *
 FROM work_orders
 WHERE work_order_id IS NULL
 OR plant_id IS NULL
 OR asset_id IS NULL
 OR vendor_id IS NULL
 OR reported_date IS NULL
 OR closed_date IS NULL
 OR status IS NULL
 OR priority IS NULL
 OR maintenance_type IS NULL
 OR failure_code IS NULL
 OR root_cause IS NULL
 OR downtime_hours IS NULL
 OR labour_hours IS NULL
 OR material_cost IS NULL
 OR labour_cost IS NULL
 OR external_cost IS NULL
 OR budget_cost IS NULL
 OR emergency_flag IS NULL
 OR description IS NULL
 OR total_cost IS NULL) AS null_checks
UNION ALL
SELECT 
'inspections' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
 SELECT *
 FROM inspections
 WHERE inspection_id IS NULL
 OR plant_id IS NULL
 OR asset_id IS NULL
 OR inspection_date IS NULL
 OR inspection_type IS NULL
 OR inspector_type IS NULL
 OR result IS NULL
 OR severity IS NULL
 OR finding_category IS NULL
 OR finding_text IS NULL
 OR corrective_action_due IS NULL
 OR  closed_flag IS NULL) AS null_checks
UNION ALL
SELECT 
'meter_readings' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
 SELECT *
 FROM meter_readings
 WHERE reading_id IS NULL
 OR plant_id IS NULL
 OR asset_id IS NULL
 OR reading_timestamp IS NULL
 OR parameter IS NULL
 OR reading_value IS NULL
 OR unit IS NULL
 OR quality_flag IS NULL
 OR source IS NULL) AS null_checks
UNION ALL
SELECT 
'purchase_orders' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
 SELECT *
    FROM purchase_orders
    WHERE po_id IS NULL
    OR plant_id IS NULL
    OR vendor_id IS NULL
    OR inventory_id IS NULL
    OR po_date IS NULL
    OR promised_date IS NULL
    OR received_date IS NULL
    OR status IS NULL
    OR quantity_ordered IS NULL
    OR quantity_received IS NULL
    OR unit_price IS NULL
    OR expedite_flag IS NULL
    OR po_value IS NULL) AS null_checks
UNION ALL
SELECT 
'financial_transactions' AS table_name,
COUNT(*) AS null_issues,
CASE
    WHEN COUNT(*) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
    SELECT *
    FROM financial_transactions
    WHERE transaction_id IS NULL
    OR plant_id IS NULL
    OR vendor_id IS NULL
    OR work_order_id IS NULL
    OR transaction_date IS NULL
    OR cost_centre IS NULL
    OR account_code IS NULL
    OR transaction_type IS NULL
    OR amount IS NULL
    OR currency IS NULL
    OR description IS NULL) AS null_checks;

SELECT 
'assets' AS table_name,
COUNT(DISTINCT plant_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT plant_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT a.plant_id
FROM assets AS a
LEFT JOIN plants AS p ON a.plant_id = p.plant_id
WHERE p.plant_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'inventory' AS table_name,
COUNT(DISTINCT plant_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT plant_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT i.plant_id
FROM inventory AS i
LEFT JOIN plants AS p ON i.plant_id = p.plant_id
WHERE p.plant_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'inventory' AS table_name,
COUNT(DISTINCT preferred_vendor_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT preferred_vendor_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT i.preferred_vendor_id
FROM inventory AS i
LEFT JOIN vendors AS v ON i.preferred_vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'work_orders' AS table_name,
COUNT(DISTINCT plant_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT plant_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT w.plant_id
FROM work_orders AS w
LEFT JOIN plants AS p ON w.plant_id = p.plant_id
WHERE p.plant_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'work_orders' AS table_name,
COUNT(DISTINCT asset_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT asset_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT w.asset_id
FROM work_orders AS w
LEFT JOIN assets AS a ON w.asset_id = a.asset_id
WHERE a.asset_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'work_orders' AS table_name,
COUNT(DISTINCT vendor_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT vendor_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT w.vendor_id
FROM work_orders AS w
LEFT JOIN vendors AS v ON w.vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'inspections' AS table_name,
COUNT(DISTINCT plant_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT plant_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT ip.plant_id
FROM inspections AS ip
LEFT JOIN plants AS p ON ip.plant_id = p.plant_id
WHERE p.plant_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'inspections' AS table_name,
COUNT(DISTINCT asset_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT asset_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT ip.asset_id
FROM inspections AS ip
LEFT JOIN assets AS a ON ip.asset_id = a.asset_id
WHERE a.asset_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'meter_readings' AS table_name,
COUNT(DISTINCT plant_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT plant_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT mr.plant_id
FROM meter_readings AS mr
LEFT JOIN plants AS p ON mr.plant_id = p.plant_id
WHERE p.plant_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'meter_readings' AS table_name,
COUNT(DISTINCT asset_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT asset_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT mr.asset_id
FROM meter_readings AS mr
LEFT JOIN assets AS a ON mr.asset_id = a.asset_id
WHERE a.asset_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'purchase_orders' AS table_name,
COUNT(DISTINCT plant_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT plant_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT po.plant_id
FROM purchase_orders AS po
LEFT JOIN plants AS p ON po.plant_id = p.plant_id
WHERE p.plant_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'purchase_orders' AS table_name,
COUNT(DISTINCT vendor_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT vendor_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT po.vendor_id
FROM purchase_orders AS po
LEFT JOIN vendors AS v ON po.vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'purchase_orders' AS table_name,
COUNT(DISTINCT inventory_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT inventory_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT po.inventory_id
FROM purchase_orders AS po
LEFT JOIN inventory AS i ON po.inventory_id = i.inventory_id
WHERE i.inventory_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'financial_transactions' AS table_name,
COUNT(DISTINCT plant_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT plant_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT ft.plant_id
FROM financial_transactions AS ft
LEFT JOIN plants AS p ON ft.plant_id = p.plant_id
WHERE p.plant_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'financial_transactions' AS table_name,
COUNT(DISTINCT vendor_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT vendor_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT ft.vendor_id
FROM financial_transactions AS ft
LEFT JOIN vendors AS v ON ft.vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL) AS relationship_checks
UNION ALL
SELECT 
'financial_transactions' AS table_name,
COUNT(DISTINCT work_order_id) AS relationship_issues,
CASE
    WHEN COUNT(DISTINCT work_order_id) = 0 THEN 'Pass'
    ELSE 'Fail'
    END AS validation_status
FROM (
SELECT DISTINCT ft.work_order_id
FROM financial_transactions AS ft
LEFT JOIN work_orders AS w ON ft.work_order_id = w.work_order_id
WHERE w.work_order_id IS NULL) AS relationship_checks;
 