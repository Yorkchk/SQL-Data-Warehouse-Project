TRUNCATE TABLE silver.erp_px_cat_g1v2;

INSERT INTO silver.erp_px_cat_g1v2
SELECT *
FROM bronze.erp_px_cat_g1v2
;
