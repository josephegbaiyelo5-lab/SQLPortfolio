/* which vendor has the greatest comercial exposure */

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