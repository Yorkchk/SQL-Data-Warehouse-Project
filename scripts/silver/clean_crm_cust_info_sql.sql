DROP TABLE IF EXISTS trimmed_table;
CREATE TEMPORARY TABLE trimmed_table as
	SELECT TRIM(cst_id) as cst_id,TRIM(cst_key) as cst_key
    ,TRIM(cst_firstname) cst_firstname,TRIM(cst_lastname) cst_lastname,
    TRIM(cst_marital_status) cst_marital_status
    ,TRIM(cst_gndr) cst_gndr,TRIM(cst_create_date) cst_create_date
    FROM bronze.crm_cust_info;
    
DELETE FROM trimmed_table
WHERE cst_id = '';

DROP TABLE IF EXISTS noblank_table;
CREATE TEMPORARY TABLE noblank_table as
	SELECT cst_id, MAX(cst_key) as cst_key, MAX(cst_firstname) as cst_firstname, MAX(cst_lastname) as cst_lastname,
	MAX(cst_marital_status) as cst_marital_status, cst_gndr, MIN(cst_create_date) as cst_create_date
	FROM trimmed_table
	GROUP BY cst_id
	;
   
DROP TABLE IF EXISTS cleaned_crm_cust_info_table;
CREATE TEMPORARY TABLE cleaned_crm_cust_info_table as
	SELECT noblank_table.cst_id, noblank_table.cst_key, noblank_table.cst_firstname, noblank_table.cst_lastname,
case 
		WHEN noblank_table.cst_marital_status = 'S' then 'Single'
        WHEN noblank_table.cst_marital_status = 'M' then 'Married'
    END as cst_marital_status,
case 
		WHEN noblank_table.cst_gndr = 'M' then 'Male'
        WHEN noblank_table.cst_gndr = 'F' then 'Female'
    END as cst_gndr,
    noblank_table.cst_create_date
	FROM noblank_table
	ORDER BY noblank_table.cst_id
	;

TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info
SELECT * FROM cleaned_crm_cust_info_table;
