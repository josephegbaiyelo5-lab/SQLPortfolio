/* data validation for NULL values in each table */

-- Check for NULL values in plants
SELECT *
FROM plants
WHERE plant_id IS NULL
   OR plant_name IS NULL
   OR region IS NULL
   OR treatment_type IS NULL
   OR capacity_mld IS NULL
   OR commissioned_year IS NULL
   OR regulator IS NULL;

   -- Check for NULL values in vendors
SELECT *
FROM vendors
WHERE vendor_id IS NULL
   OR vendor_name IS NULL
   OR vendor_category IS NULL
   OR country IS NULL
   OR payment_terms_days IS NULL
   OR approved_supplier IS NULL
   OR quality_rating IS NULL;

   -- Check for NULL values in assets
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
   OR energy_class IS NULL;

 -- Check for NULL values in inventory
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
 OR stock_value IS NULL;

 -- Check for NULL values in work_orders
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
 OR total_cost IS NULL;

 -- Check for NULL values in inspections
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
 OR  closed_flag IS NULL;

 -- Check for NULL values in meter_readings
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
 OR source IS NULL;

 -- Check for NULL values in purchase_orders
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
    OR po_value IS NULL;

    -- Check for NULL values in financial_transactions
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
    OR description IS NULL;
 