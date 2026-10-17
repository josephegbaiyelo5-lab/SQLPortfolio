# Introduction
This project dive into the Water and Wastewater industry using a simulated dataset created for portfolio and analystical practice purposes. It is designed to resemble the type of operational, maintenance, asset, procurement, regulatory and financial data that anlysts may encounter in the Water and Wastewater industry.

The dataset does not contain confidential, properietry, personal or real operational data from any Water industry or treatment organisation.

The business questions, SQL analysis and recommendations are based on the simulated data and should not be interpreted as findings about any real organisation.

SQL queries? Check them out here: [Water_Waste_Project_sql folder](/Water_%20Waste%20_Project.sql/)

# Background
This project was driven by looking at some operational, maintenance, regulatory and financial challenges in the Water and Wastewater industry.

There are 9 linked simulated CSV tables containing 170,000 plus records covering treatment plants, assets, work orders, inventory, vendors, meter reading, purchase orders and financial transactions.

## The questions I want to answer through my queries are
1. Which assets have the poorest reliability performance relatively to 'Critical' criticality?
2. List waste disposals that have maintenance type expenditure exceed budget?
3. What percentage of downtime is caused by top 5 failure mechanisms?
4. What percentage of downtime is caused by top 5 root causes?
5. What percentage of downtime is caused by calibration drift ELEC failure mechanism for each plant?
6. Which vendor has the greatest commercial exposure?
7. Which plants have the highest regulatory risk?
8. What is the percentage of failed regulatory inspections for each plant?
9. Which plants have the highest regulatory inspections failed percentage?
10. Which inventory items require immediate reorder?
11. What percentage of inventory items require replenishment?
12. Which parts are below reorder point?
13. Which plants have the highest inevtory shortages?
14. Which inentory items have the highest financial exposure?
15. Which plant has the highest maintetnance cost within each region?
16. Did maintenance expenditure increase or decrease compared with the previous month?
17. Do assets receiving more preventive maintenance experience fewer failure?
18. Which assets reading with historian sources are suspcious?
19. What percentage of SCADA readings are good quality within each plant?
20. Which vendors have the poorest delivery based on late-delivery frequency, average delay days and maximum delay?
21. Which asset has the poorest reliability?

# Tools I Used
For my deep dive into the Water and Wastewater operations SQL portfolio, I harnessed the power of several key tools

- **SQL**: This is the backbone of my analysis, allowing to me to query the database and perform critical insights.
- **Postgresql**: The chosen database management system.
- **Visual Studio Code**: My go to for database management and executing SQL queries.
- **Git and GitHub**: Essential for sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Prior to answering the business questions above, I created tables for the 9 linked CSV and loaded these tables.

I also performed data validations in areas such as row counts, NULL checks, duplicate checks and relationship checks. The outcomes are as follows:

### Row Counts
To identify if row counts tallies with 174,635 created rows for this project 

```SQL
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
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Row_Count.png?raw=true)

Results: All expected tables are populated.

### Duplicate Checks
To identify that there are no records of duplicates for primary keys.

```SQL
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
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Duplicate_Checks.png?raw=true)

Result: No record of duplicates for primary keys.

### NULL Checks
To identify NULL values in each table.

```SQL
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
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/NULL_Checks.png?raw=true)

Result: No record of NULL value in each table.

### Relationship Checks
To identify relationships betweem item(s) between tables.

```SQL
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
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Relationship_Check.png?raw=true)

Result: No orphaned relationship identified

Each business query was performed to analysed some critical issues as follows:

### Which assets have the poorest reliability performance relatively to 'Critical' criticality?

```SQL
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
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Business-ans_Asset.png?raw=true)



![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Average%20Downtime%20vs%20Average%20Failure.png?raw=true)
I generated this chart in Excel.

Findings:
A100593 has an average failure of 57 and avergae downtime of 572.47 hours. Other assets with high observed frequency are A100691,A101267,A100259 and so on.

Recommendation:
Prioritise reliability performance review for asset criticality with high downtime and high failure rate.

### List waste disposals that have maintenance type expenditure exceed budget?

```SQL
WITH cost_exceed_budget AS (
    SELECT
    w.maintenance_type,
    ft.description,
        SUM(w.total_cost) AS total_actual,
        SUM(w.budget_cost) AS total_budget
    FROM work_orders AS w
    LEFT JOIN financial_transactions AS ft ON w.work_order_id = ft.work_order_id
    GROUP BY w.maintenance_type, ft.description
    HAVING ft.description = 'Waste disposal'
)
SELECT
    maintenance_type,
    description,
    total_actual,
    total_budget,
    total_actual - total_budget AS exceed_amount,
    ROUND((total_actual - total_budget) * 100.0 / total_budget, 2) AS exceed_percentage
FROM cost_exceed_budget
ORDER BY exceed_amount DESC;
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Business_ans_budget.png?raw=true)

Findings:
Three of the maintenance types waste disposal exceeded budget by at least 30%.

Recommendations:
Investigate maintenance type waste disposal with high expenditure.

### What percentage of downtime is caused by top 5 failure mechanisms?

```SQL
SELECT
    failure_code,
    SUM(downtime_hours) AS total_downtime,
    ROUND((SUM(downtime_hours) / (SELECT SUM(downtime_hours) FROM work_orders)) * 100, 2) AS downtime_percentage
FROM work_orders
GROUP BY failure_code
ORDER BY total_downtime DESC
LIMIT 5;
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Top_5-failure_mechanism.png?raw=true)

Findings:
Top 5 failure mechanisms as a result of downtime are mechanical, none, electrical, instrument and process with downtime of 24% down to 12% respectively.

Recommendations:
Prioritise review of top failure mechanisms with high downtime hours.

### What percentage of downtime is caused by top 5 root causes?

```SQL
SELECT
    root_cause,
    SUM(downtime_hours) AS total_downtime,
    ROUND((SUM(downtime_hours) / (SELECT SUM(downtime_hours) FROM work_orders)) * 100, 2) AS downtime_percentage
FROM work_orders
GROUP BY root_cause
ORDER BY total_downtime DESC
LIMIT 5;
```
Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Top_5-root_cause.png?raw=true)

Findings:
Top 5 root causes as a result of downtime are wear, unknown, electrical fault, corrosion and blocked line with downtime of 16% down to 12% respectively.

Recommendations:
Prioritise review of top root causes with high downtime hours.

### What percentage of downtime is caused by calibration drift ELEC failure mechanism for each plant?

```SQL
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
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Calibration_drift_ELEC.png?raw=true)

Findings:

Plant PLT1014 has the highest total downtime of 418.05 hours caused by calibration drift ELEC failure code.

Other plants are PLT1026, PLT1017, PLT1033, PLT1005, PLT1003, PLT1004 with at least a downtime of 344 hours.

Recommendations:
Investigate plants caused by calibration drift root cause and electrical failure code with high downtime.

### Which vendor has the greatest commercial exposure?

```SQL
WITH vendor_exposure AS (SELECT
    vendor_id,
    COUNT(*) AS total_pos,
    COUNT(*) FILTER (WHERE received_date > promised_date) AS late_pos,
    ROUND(COUNT(*) FILTER (WHERE received_date > promised_date) * 100.0 / NULLIF(COUNT(*), 0),2) AS late_delivery_percentage,
    SUM(po_value) AS total_po_value
FROM purchase_orders
WHERE received_date IS NOT NULL
  AND promised_date IS NOT NULL
GROUP BY vendor_id
ORDER BY total_po_value DESC, late_delivery_percentage DESC
)
SELECT
    ve.vendor_id,
    ve.late_delivery_percentage,
    ve.total_po_value,
    v.vendor_name,
    v.quality_rating,
    v.approved_supplier,
    SUM(w.total_cost) AS maintanance_spend,
    CASE
    WHEN v.quality_rating > 4 THEN 'Good'
    WHEN v.quality_rating BETWEEN 3 AND 4 THEN 'Average'
    ELSE 'Poor'
    END AS quality_rating_category
FROM vendor_exposure ve
JOIN vendors v ON ve.vendor_id = v.vendor_id
LEFT JOIN work_orders w ON ve.vendor_id = w.vendor_id
WHERE v.approved_supplier = 'Yes'
GROUP BY ve.vendor_id, ve.late_delivery_percentage, ve.total_po_value, v.quality_rating, v.approved_supplier, v.vendor_name
ORDER BY ve.total_po_value DESC, ve.late_delivery_percentage DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Greatest_commercial_exposure.png?raw=true)

Findings:
Supplier 230 represents £224440.4 purchase order value and £397724.59 maintenance spend while recording 74% late delivery rate and average quality performance.

Recommendations:
Review supplier improvement plans for high-spend, high-delay vendors.

### Which plants have the highest regulatory risk?

```SQL
SELECT
    plant_id,
    COUNT(*) AS high_risk_findings
FROM inspections
WHERE inspection_type = 'Regulatory'
  AND result = 'Fail'
  AND severity = 'High'
GROUP BY plant_id
ORDER BY high_risk_findings DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/high_regulatory_risk.png?raw=true)

Findings:
Plants PLT1000, PLT1002, PLT1016, PLT1020 and PLT1034 have the highest regulatory risk.

Recommendations:
Escalate plants with high regulatory risk.

### What is the percentage of failed regulatory inspections for each plant?

```SQL
SELECT
    plant_id,
    COUNT(*) AS total_inspections,
    SUM(CASE WHEN result = 'Fail' THEN 1 ELSE 0 END) AS failed_inspections,
    ROUND((SUM(CASE WHEN result = 'Fail' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS failure_percentage
FROM inspections
WHERE inspection_type = 'Regulatory'
GROUP BY plant_id
ORDER BY failure_percentage DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Failed_regulatory.png?raw=true)

Findings:
Plant PLT1020 has the highest failed regulatory inspections of 11% followed by PLT1003 10.67%, PLT1034 8.54% and so on.

Recommendations:
Prioritise review of plants with high failed regulatory inspections.

### Which plants have the highest regulatory inspections failed percentage?

```SQL
SELECT
    plant_id,
    COUNT(*) AS high_regulatory_inspections,
    COUNT(*) FILTER (WHERE result = 'Fail') AS failed_inspections,
    ROUND(COUNT(*) FILTER (WHERE result = 'Fail') * 100.0/ NULLIF(COUNT(*), 0),2) AS failure_rate_percent
FROM inspections
WHERE inspection_type = 'Regulatory' AND severity = 'High'
GROUP BY plant_id
ORDER BY failure_rate_percent DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/high_regulatory_inspection_failed.png?raw=true)

Findings:
Plant PLT1016 has the highest regulatory inspection failure of 20%.

Recommendations:
Investigate plants with high regulatory inspection failure.


### Which inventory items require immediate reorder?

```SQL
SELECT
inventory_id,
    COUNT(*) AS total_items,
    COUNT(*) FILTER (
        WHERE current_stock IS NOT NULL
          AND reorder_point IS NOT NULL
          AND current_stock <= reorder_point
    ) AS reorder_needed
FROM inventory
GROUP BY inventory_id
ORDER BY reorder_needed DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/inventory_immediate_reorder.png?raw=true)

Findings:
Inventories INV102687, INV104666, INV102793 and so on.

Recommendations:
Prioritise supplies of inventories requiring immediate reorder.

### What percentage of inventory items require replenishment?

```SQL
SELECT
inventory_id,
    COUNT(*) AS total_items,
    ROUND(COUNT(*) FILTER (
        WHERE current_stock IS NOT NULL
          AND reorder_point IS NOT NULL
          AND current_stock <= reorder_point
    )*100.0 / NULLIF(COUNT(*), 0), 2) AS replenishment_percentage
FROM inventory
GROUP BY inventory_id
ORDER BY replenishment_percentage DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/inventory_replenishment.png?raw=true)

Findings:
Inventories INV102687, INV104666, INV102793 and so on have replenishment of 100%.

Recommendations:
Schedule supllies of inventories with high replenishment rate.

### Which parts are below reorder point?

```SQL
SELECT
part_number,
current_stock,
reorder_point,
    CASE
        WHEN current_stock < reorder_point THEN 'Below Reorder Point'
        ELSE 'Above Reorder Point'
    END AS stock_status
    FROM inventory
    WHERE current_stock IS NOT NULL
      AND reorder_point IS NOT NULL
      GROUP BY part_number, current_stock, reorder_point
    ORDER BY stock_status DESC, current_stock ASC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/Below_reorder_point.png?raw=true)

Findings:
Parts PN-79730, PN-10105, PN-81925, PN-14734, PN-57114 and so on are below reorder point.

Recommendations:
Prioritise replenishments of parts below reorder point.

### Which plants have the highest inventory shortages?

```SQL
SELECT
plant_id,
    SUM(reorder_point - current_stock) AS total_shortage
FROM inventory
GROUP BY plant_id
ORDER BY total_shortage DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/highest-inventory_shortage.png?raw=true)

Findings:
Plants PLT1019, PLT1001, PLT1002, PLT1011, PLT1034 and so on have the highest inventory shortages.

Recommendations:
Escalate supplies of plants with high inventory shortages.


### Which inventory items have the highest financial exposure?

```SQL
SELECT
inventory_id,
    SUM(current_stock * unit_cost) AS financial_exposure
FROM inventory
GROUP BY inventory_id
ORDER BY financial_exposure DESC;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/inventory_high_financial_exposure.png?raw=true)

Findings:
Inventory INV107008 represents £27989.28 financial exposure.

Recoomendations:
Prioritise review of inventories with high-spend.

### Which plant has the highest maintetnance cost within each region?

```SQL
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
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/high_maintenance_cost_plant.png?raw=true)

Findings:
Within each region, the following plants are ranked first with high maintenance cost : 
- Central: water and wastewater facility 02 with high spend of £3870279.30
- East: water and wastewater facility 08 with high spend of £3860944.84
- North: water and wastewater facility 19 with high spend of £3847067.86
- South: water and wastewater facility 28 with high spend of £3880578.87

Recommendations:
Prioritise review of regional plant facilities with high maintenance cost.

### Did maintenance expenditure increase or decrease compared with the previous month?

```SQL
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
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/monthly_maintenance_expenditure.png?raw=true)

Findings:
Months of February, May, August, October of 2022 shows an increase in monthly expenditure compared to previous month with at least 4%.

Recommendations:
Investigate the reasons for increase in monthly expenditure compared to previous month.

### Do assets receiving more preventive maintenance experience fewer failure?

```SQL
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
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/preventive_maintenance_failure.png?raw=true)

Findings:
Assets receiving more preventive maintenance still experience high failure. For example: Asset A100346 received 20 preventive maintenance work with 34 failures, Asset A100826 received 21 preventive maintenance work with 36 failures.

Recommendations:
Prioritise review of assets with high preventive maintenance, high failure.

### Are assets with high preventive-maintenance coverage experiencing fewer failures?

```SQL
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
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/high_preventive-maintenace_coverage.png?raw=true)

Findings:
Eventhough there are no high preventive maintenance coverage, both medium and low preventive group exceeds 90% average failure rate.

Recommendations:
Investigate preventive maintenance group with high failure rate, high downtime.

### Which assets reading with historian sources are suspicious?

```SQL
SELECT
asset_id
source,
quality_flag
FROM meter_readings
WHERE source = 'Historian' AND quality_flag = 'Suspect'
GROUP BY asset_id, source, quality_flag;
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/historian_reading.png?raw=true)

Findings:
Assets A100404, A100690, A101797, A100689 and so on historian sources readings are suspicious.

Recommendations:
Prioritise review assets with suspected historian readings.


### What percentage of SCADA readings are good quality within each plant?

```SQL
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
```

Outcome:

![Preview](https://github.com/josephegbaiyelo5-lab/SQLPortfolio/blob/main/Resource/SCADA_reading.png?raw=true)

Findings:
Plants PLT1000, PLT1024, PLT1019, PLT1011, PLT1008, PLT1027, PLT1033 and PLT1004 have at least 66% SCADA good quality rating.

Recommendations:
Schedule an improvement plan of how to achieve higher SCADA good quality rating.

### Which vendors have the poorest delivery based on late-delivery frequency, average delay days and maximum delay?

```SQL

SELECT
    vendor_id,
    COUNT(*) AS total_pos,
    COUNT(*) FILTER (WHERE received_date > promised_date) AS late_pos,
    ROUND(COUNT(*) FILTER (WHERE received_date > promised_date) * 100.0 / NULLIF(COUNT(*), 0),2) AS late_delivery_percentage,
    ROUND(AVG(CASE WHEN received_date > promised_date THEN received_date - promised_date ELSE NULL END), 2) AS avg_delay_days,
    MAX(CASE WHEN received_date > promised_date THEN received_date - promised_date ELSE NULL END) AS max_delay_days,
        CASE
        WHEN AVG(CASE WHEN received_date > promised_date THEN received_date - promised_date ELSE NULL END) > 0 THEN 'Poor'
                WHEN AVG(CASE WHEN received_date = promised_date THEN 0 ELSE NULL END) = 0 THEN 'On Time'
                ELSE 'Early'
            END AS delivery_performance
FROM purchase_orders
WHERE received_date IS NOT NULL
  AND promised_date IS NOT NULL
GROUP BY vendor_id
ORDER BY late_delivery_percentage DESC, avg_delay_days DESC, max_delay_days DESC
LIMIT 20;
```

Outcome:

![vendor_poor_delivery](Resource\Business_ans_vendor.png)

Findings:
- Vendor V10234 has 85% late delivery, 35 average delay days and 80 maximum delay days
-  Vendor V10261 has 79% late delivery, 29 average delay days and 83 maximum delay days
-  Vendor V10056 has 78% late delivery, 31 average delay days and 77 maximum delay days
-  Vendor V10264 has 77% late delivery, 31 average delay days and 72 maximum delay days and so on.

Recommendations:
Review vendor improvement plan for poor delivery and high delay days.

### Which asset has the poorest reliability?

```SQL
 SELECT
    asset_id,
    COUNT(failure_code) AS failure_count,
    COALESCE(ROUND(AVG(downtime_hours) FILTER (WHERE status = 'closed'),2), 0) AS mttr_hours,
    ROUND(8760.0 / NULLIF(COUNT(failure_code), 0),2) AS mtbf_hours
FROM work_orders
GROUP BY asset_id
ORDER BY mtbf_hours ASC;
```

Outcome:

![assest_poor_reliability](Resource\Business_ans_workorder.png)

Findings:
Asset A100507 is the least reliable with mean time between failures of 141.29 hours.

Recommendations:
Prioritise reliability review of assets with high mean time between failures hours.

# What I Learned

Through this Water and Wastewater Operations project, I developed practical skills in SQL, data cleaning, data validation, and operational data analysis. I learned how to structure SQL queries to retrieve, filter, aggregate, and analyse data to identify useful insights about water and wastewater treatment operations.

I also gained experience in implementing data-quality checks, particularly identifying missing values in critical fields such as plant IDs, treatment types, treatment capacity, commissioning years, and regulatory information. This helped me understand the importance of data accuracy, completeness, and consistency when working with operational datasets.

Another key learning was how to translate raw data into meaningful information that can support decision-making. By examining treatment plant information, regional distribution, and operational capacity, I developed a better understanding of how data analysis can support infrastructure planning, performance monitoring, and operational improvements.

Finally, I learned that technical analysis is only one part of a successful data project. Writing clear SQL queries, validating results, documenting findings, and communicating insights effectively are equally important. Overall, this project strengthened my SQL skills and improved my ability to approach real-world operational problems using a structured, data-driven methodology.


# Conclusion:

This Water and Wastewater Operations project demonstrates how data analysis and SQL can be used to assess operational performance, improve data quality, and support informed decision-making within water and wastewater treatment operations.

Through the analysis of treatment plants, operational capacity, regional distribution, treatment types, commissioning years, and regulatory information, the project establishes a structured approach to understanding the water and wastewater infrastructure. SQL queries were used to explore the data, identify potential data-quality issues, and perform validation checks to improve the reliability and consistency of the information.

Data quality validation was an important part of the project, as missing values in critical fields can affect reporting accuracy and the reliability of operational insights. Implementing validation rules helps identify incomplete records and establishes a foundation for more dependable analysis and reporting.

This project also highlights the importance of monitoring treatment capacity, understanding regional differences, and maintaining accurate operational records to support effective resource planning and infrastructure management. These insights can help stakeholders identify areas requiring further investigation, prioritise maintenance and investment, and strengthen operational oversight.

Overall, this project demonstrates the practical value of SQL and data-driven analysis in the water and wastewater sector. Future improvements could include integrating real-time operational data, monitoring treatment efficiency, tracking regulatory compliance, and developing interactive dashboards to monitor key performance indicators. By building on these capabilities, water and wastewater organisations can improve operational visibility, support evidence-based decisions, and work towards more efficient, reliable, and sustainable water services.
