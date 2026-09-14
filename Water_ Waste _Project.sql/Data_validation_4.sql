/* validate relationship between tables */

-- relationship in assets
SELECT DISTINCT a.plant_id
FROM assets AS a
LEFT JOIN plants AS p ON a.plant_id = p.plant_id
WHERE p.plant_id IS NULL;

-- relationship in inventory plant_id and vendor_id
SELECT DISTINCT i.plant_id
FROM inventory AS i
LEFT JOIN plants AS p ON i.plant_id = p.plant_id
WHERE p.plant_id IS NULL;

SELECT DISTINCT i.preferred_vendor_id
FROM inventory AS i
LEFT JOIN vendors AS v ON i.preferred_vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL;

-- relationship in work_orders plant_id, asset_id and vendor_id
SELECT DISTINCT w.plant_id
FROM work_orders AS w
LEFT JOIN plants AS p ON w.plant_id = p.plant_id
WHERE p.plant_id IS NULL;

SELECT DISTINCT w.asset_id
FROM work_orders AS w
LEFT JOIN assets AS a ON w.asset_id = a.asset_id
WHERE a.asset_id IS NULL;

SELECT DISTINCT w.vendor_id
FROM work_orders AS w
LEFT JOIN vendors AS v ON w.vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL;

-- relationship in inspections plant_id and asset_id
SELECT DISTINCT ip.plant_id
FROM inspections AS ip
LEFT JOIN plants AS p ON ip.plant_id = p.plant_id
WHERE p.plant_id IS NULL;

SELECT DISTINCT ip.asset_id
FROM inspections AS ip
LEFT JOIN assets AS a ON ip.asset_id = a.asset_id
WHERE a.asset_id IS NULL;

-- relationship in meter_readings plant_id and asset_id
SELECT DISTINCT mr.plant_id
FROM meter_readings AS mr
LEFT JOIN plants AS p ON mr.plant_id = p.plant_id
WHERE p.plant_id IS NULL;

SELECT DISTINCT mr.asset_id
FROM meter_readings AS mr
LEFT JOIN assets AS a ON mr.asset_id = a.asset_id
WHERE a.asset_id IS NULL;

-- relationship in purchase_orders plant_id, vendor_id and inventory_id
SELECT DISTINCT po.plant_id
FROM purchase_orders AS po
LEFT JOIN plants AS p ON po.plant_id = p.plant_id
WHERE p.plant_id IS NULL;

SELECT DISTINCT po.vendor_id
FROM purchase_orders AS po
LEFT JOIN vendors AS v ON po.vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL;

SELECT DISTINCT po.inventory_id
FROM purchase_orders AS po
LEFT JOIN inventory AS i ON po.inventory_id = i.inventory_id
WHERE i.inventory_id IS NULL;

-- relationship in financial_transactions plant_id, vendor_id and work_order_id
SELECT DISTINCT ft.plant_id
FROM financial_transactions AS ft
LEFT JOIN plants AS p ON ft.plant_id = p.plant_id
WHERE p.plant_id IS NULL;

SELECT DISTINCT ft.vendor_id
FROM financial_transactions AS ft
LEFT JOIN vendors AS v ON ft.vendor_id = v.vendor_id
WHERE v.vendor_id IS NULL;

SELECT DISTINCT ft.work_order_id
FROM financial_transactions AS ft
LEFT JOIN work_orders AS w ON ft.work_order_id = w.work_order_id
WHERE w.work_order_id IS NULL;