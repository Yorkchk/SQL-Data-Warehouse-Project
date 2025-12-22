TRUNCATE TABLE silver.erp_loc_a101;

INSERT INTO silver.erp_loc_a101
SELECT
REPLACE(CID, '-', '') as CID,
case
	when CNTRY = 'US' or CNTRY = 'USA' then 'United States'
    when CNTRY = 'DE' then 'Germany'
    when CNTRY = '' then null
    else CNTRY
end as CNTRY
FROM bronze.erp_loc_a101
;
