TRUNCATE TABLE silver.crm_prd_info;

INSERT INTO silver.crm_prd_info
with cte as
(
SELECT *,
row_number() OVER(PARTITION BY prd_nm ORDER BY prd_start_dt) as row_num
FROM bronze.crm_prd_info
),
cte1 as
(
	SELECT prd_id,prd_key, prd_nm, prd_cost, prd_line,prd_start_dt,
case
	when prd_end_dt = '' then null
    else prd_end_dt
END as prd_end_dt,
	row_num,
	LEAD(prd_start_dt, 1, NULL) OVER() as lagged_start_dt,
	LEAD(row_num, 1, 1) OVER() as lagged_row_num
	FROM cte
)
SELECT prd_id,
	REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') as cat_id,
    SUBSTRING(prd_key, 7, LENGTH(prd_key)) as prd_key,
    prd_nm,
    IFNULL(prd_cost, 0) as prd_cost,
case
	when TRIM(prd_line) = 'R' then 'Road'
	when TRIM(prd_line) = 'S' then 'Other Sales'
	when TRIM(prd_line) = 'M' then 'Mountain'
	when TRIM(prd_line) = 'T' then 'Touring'
    else 'n/a'
END as prd_line,
case
	when (row_num = 1 and lagged_row_num = 1) and NOT ISNULL(prd_end_dt) then prd_end_dt
    ELSE prd_start_dt
end as prd_start_dt,
case
	when lagged_row_num != 1 then lagged_start_dt
    when row_num != 1 and lagged_row_num = 1 then null
    when (row_num = 1 and lagged_row_num = 1) and NOT ISNULL(prd_end_dt) then prd_start_dt
    ELSE prd_end_dt
END as prd_end_dt
FROM cte1
ORDER BY prd_id
;
