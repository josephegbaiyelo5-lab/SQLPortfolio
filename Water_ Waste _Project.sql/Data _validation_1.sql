/* calculate row count for each table
*/

SELECT 
    'plants' AS table_name, 
    COUNT(*) AS row_count
    FROM plants
    UNION ALL
    SELECT 
    'vendors' AS table_name,
    COUNT(*) AS row_count
    FROM vendors
    UNION ALL
    SELECT 
    'assets' AS table_name,
    COUNT(*) AS row_count
    FROM assets
    UNION ALL
    SELECT 
    'inventory' AS table_name,
    COUNT(*) AS row_count
    FROM inventory
    UNION ALL
    SELECT 
    'work_orders' AS table_name,
    COUNT(*) AS row_count
    FROM work_orders
    UNION ALL
    SELECT
    'inspections' AS table_name,
    COUNT(*) AS row_count
    FROM inspections
    UNION ALL
    SELECT
    'meter_readings' AS table_name,
    COUNT(*) AS row_count
    FROM meter_readings
    UNION ALL
    SELECT
    'purchase_orders' AS table_name,
    COUNT(*) AS row_count
    FROM purchase_orders
    UNION ALL
    SELECT
    'financial_transactions' AS table_name,
    COUNT(*) AS row_count
    FROM financial_transactions;
    