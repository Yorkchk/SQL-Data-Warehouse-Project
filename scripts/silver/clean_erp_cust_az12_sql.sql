TRUNCATE TABLE silver.erp_cust_az12;

INSERT INTO silver.erp_cust_az12
SELECT 
case
	when CID LIKE 'NAS%' then SUBSTRING(CID,4, length(CID))
    else CID
END as CID,
case
	when BDATE > NOW() then null
    else BDATE
end as BDATE,
case
	when GEN = 'M' then 'Male'
	when GEN = 'F' then 'Female'
	when GEN = '' then null
    else GEN
end as GEN
FROM bronze.erp_cust_az12
;
