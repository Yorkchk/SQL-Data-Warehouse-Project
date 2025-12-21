TRUNCATE TABLE silver.crm_sales_details;

INSERT INTO silver.crm_sales_details
with cte as
(
SELECT 
TRIM(sls_ord_num) as sls_ord_num,
TRIM(sls_prd_key) as sls_prd_key,
TRIM(sls_cust_id) as sls_cust_id,
case
	when sls_order_dt = 0 then null
    ELSE CAST(CONCAT(SUBSTRING(sls_order_dt, 1, 4), '-',SUBSTRING(sls_order_dt, 5, 2), '-', SUBSTRING(sls_order_dt, 7, LENGTH(sls_order_dt))) as date)
END AS sls_order_dt,
case
	when sls_ship_dt = 0 then null
    ELSE CAST(CONCAT(SUBSTRING(sls_ship_dt, 1, 4), '-',SUBSTRING(sls_ship_dt, 5, 2), '-', SUBSTRING(sls_ship_dt, 7, LENGTH(sls_ship_dt))) as date)
END AS sls_ship_dt,
case
	when sls_due_dt = 0 then null
    ELSE CAST(CONCAT(SUBSTRING(sls_due_dt, 1, 4), '-',SUBSTRING(sls_due_dt, 5, 2), '-', SUBSTRING(sls_due_dt, 7, LENGTH(sls_due_dt))) as date)
END as sls_due_dt,
case
	when sls_sales IS NULL then 0
    when sls_sales < 0 then abs(sls_sales)
    ELSE sls_sales
END AS sls_sales,
abs(sls_quantity) as sls_quantity,
case
	when sls_price IS NULL then 0
    when sls_price < 0 then abs(sls_price)
    ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details
ORDER BY sls_ord_num
)

SELECT *
FROM(
SELECT sls_ord_num,sls_prd_key,sls_cust_id,sls_order_dt,sls_ship_dt,sls_due_dt,
case
	when (sls_sales != sls_quantity * sls_price) and sls_price != 0 then sls_quantity * sls_price
    ELSE sls_sales
END as sls_sales,
sls_quantity,
case
	when (sls_sales != sls_quantity * sls_price) and sls_sales != 0 and sls_price = 0 then ROUND(sls_sales / sls_quantity)
    ELSE sls_price
END AS sls_price
FROM cte
)t
;