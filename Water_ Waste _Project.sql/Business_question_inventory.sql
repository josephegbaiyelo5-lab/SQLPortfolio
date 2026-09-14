/* Which inventory items require immediate reorder?
What % of inventory items require replenishment?
Which parts are below reorder point?
Which plants have the highest inventory shortages?
Which inventory items have the highest financial exposure?
*/
 -- which inventory items require immediate reorder?

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

-- What % of inventory items require replenishment?

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

-- Which parts are below reorder point?
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

-- Which plants have the highest inventory shortages?
SELECT
plant_id,
    SUM(reorder_point - current_stock) AS total_shortage
FROM inventory
GROUP BY plant_id
ORDER BY total_shortage DESC;

-- Which inventory items have the highest financial exposure?
SELECT
inventory_id,
    SUM(current_stock * unit_cost) AS financial_exposure
FROM inventory
GROUP BY inventory_id
ORDER BY financial_exposure DESC;