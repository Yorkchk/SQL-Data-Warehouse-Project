CREATE OR REPLACE VIEW gold.dim_products AS
SELECT 
pm.prd_id as Product_id,
pm.cat_id as Category_id,
pm.prd_key as Product_key,
pm.prd_nm as Product_name,
pm.prd_cost as Product_cost,
pm.prd_line as Product_line,
pm.prd_start_dt as start_date,
ps.CAT as Product_category,
ps.SUBCAT as Product_subcategory,
ps.MAINTENANCE as maintenance
FROM silver.crm_prd_info pm
JOIN silver.erp_px_cat_g1v2 ps
ON pm.cat_id = ps.ID
where pm.prd_end_dt IS NULL
;
