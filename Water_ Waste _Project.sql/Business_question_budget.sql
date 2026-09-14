/* List Waste disposals that have maintenance type expenditure exceed budget */
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