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
	MAX(cst_marital_status) as cst_marital_status, MAX(cst_gndr) as cst_gndr, MIN(cst_create_date) as cst_create_date
	FROM trimmed_table
	GROUP BY cst_id
	;

DROP TABLE IF EXISTS filtered_names_table;
CREATE TEMPORARY TABLE filtered_names_table as
	with filter_names_by_gender_cte as
	(
		SELECT *,
		ROW_NUMBER() OVER(PARTITION BY `name` ORDER BY total_count DESC) as row_num
		FROM names_info.cust_name_table as cust_names
	)
	SELECT `name`, gender
	FROM filter_names_by_gender_cte
	where row_num = 1
	;
    
DROP TABLE IF EXISTS cleaned_crm_cust_info_table;
CREATE TEMPORARY TABLE cleaned_crm_cust_info_table as
	SELECT noblank_table.cst_id, noblank_table.cst_key, noblank_table.cst_firstname, noblank_table.cst_lastname, noblank_table.cst_marital_status,
	cust_names.gender as cust_gndr, noblank_table.cst_create_date
	FROM noblank_table
	JOIN filtered_names_table as cust_names
	ON cust_names.`name` = noblank_table.cst_firstname
	ORDER BY noblank_table.cst_id
	;
