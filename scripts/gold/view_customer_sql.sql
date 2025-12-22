CREATE OR REPLACE VIEW gold.dim_customers AS
SELECT 
ca.cst_id as customer_id,
ca.cst_key as customer_key,
ca.cst_firstname as first_name,
ca.cst_lastname as last_name,
ca.cst_marital_status as marital_status,
case
	when ca.cst_gndr != '' then ca.cst_gndr 
    ELSE IFNULL(ci1.GEN, 'n/a')
END as gender,
ca.cst_create_date as Date_created,
ci1.BDATE as birth_date,
ci2.CNTRY as country
FROM silver.crm_cust_info ca
JOIN silver.erp_cust_az12 ci1
ON ca.cst_key = ci1.CID
JOIN silver.erp_loc_a101 ci2
ON ca.cst_key = ci2.CID
;
