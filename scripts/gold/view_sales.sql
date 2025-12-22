CREATE OR REPLACE VIEW gold.fact_sales AS
SELECT
sd.sls_ord_num as order_number,
pr.product_key as Produt_key,
cu.customer_id as customer_id,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as order_due_date,
sd.sls_sales as sales,
sd.sls_quantity as order_quantity,
sd.sls_price as price
FROM silver.crm_sales_details sd
JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.Product_key
LEFT JOIN gold.dim_customers cu
on sd.sls_cust_id = cu.customer_id
;
