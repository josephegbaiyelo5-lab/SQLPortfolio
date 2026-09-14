/* Primary key duplicate check for the table water_waste_project */

-- Check for duplicate primary key in plants
SELECT plant_id, COUNT(*) AS duplicate_count
FROM plants
GROUP BY plant_id
HAVING COUNT(*) > 1;

 -- Check for duplicate primary key in vendors
SELECT vendor_id, COUNT(*) AS duplicate_count
FROM vendors
GROUP BY vendor_id
HAVING COUNT(*) > 1;

 -- Check for duplicate primary key in assets
SELECT asset_id, COUNT(*) AS duplicate_count
FROM assets
GROUP BY asset_id
HAVING COUNT(*) > 1;

 -- Check for duplicate primary key in inventory
SELECT inventory_id, COUNT(*) AS duplicate_count
FROM inventory
GROUP BY inventory_id
HAVING COUNT(*) > 1;

 -- Check for duplicate primary key in work_orders
SELECT work_order_id, COUNT(*) AS duplicate_count
FROM work_orders
GROUP BY work_order_id
HAVING COUNT(*) > 1;

 -- Check for duplicate primary key in inspections
SELECT inspection_id, COUNT(*) AS duplicate_count
FROM inspections
GROUP BY inspection_id
HAVING COUNT(*) > 1;

-- Check for duplicate primary key in meter_readings
SELECT reading_id, COUNT(*) AS duplicate_count
FROM meter_readings
GROUP BY reading_id
HAVING COUNT(*) > 1;

-- Check for duplicate primary key in purchase_orders
SELECT po_id, COUNT(*) AS duplicate_count
FROM purchase_orders
GROUP BY po_id
HAVING COUNT(*) > 1;

-- Check for duplicate primary key in financial_transactions
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM financial_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

