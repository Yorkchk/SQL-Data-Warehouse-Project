	SET SESSION sql_mode = '';
SET @start_time1 = NOW(3);
	TRUNCATE TABLE bronze.crm_cust_info;
	LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_info.csv' 
	INTO TABLE bronze.crm_cust_info 
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n' 
	IGNORE 1 LINES;
SET @end_time1 = NOW(3);

SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time1, @end_time1)/1000,1) as Time_Load_crm_cust_info; 


SET @start_time2 = NOW(3);
	TRUNCATE TABLE bronze.crm_prd_info;
	LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prd_info.csv' 
	INTO TABLE bronze.crm_prd_info 
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n' 
	IGNORE 1 LINES;
SET @end_time2 = NOW(3);

SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time2, @end_time2)/1000,1) as Time_Load_crm_prd_info ; 

SET @start_time3 = NOW(3);
	TRUNCATE TABLE bronze.crm_sales_details;
	LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_details.csv' 
	INTO TABLE bronze.crm_sales_details
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n' 
	IGNORE 1 LINES;
SET @end_time3 = NOW(3);

SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time3, @end_time3)/1000,1) as Time_Load_crm_sales_details;

SET @start_time4 = NOW(3);
	TRUNCATE TABLE bronze.erp_cust_az12;
	LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CUST_AZ12.csv' 
	INTO TABLE bronze.erp_cust_az12
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n' 
	IGNORE 1 LINES;
SET @end_time4 = NOW(3);

SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time4, @end_time4)/1000,1) as Time_Load_erp_cust_az12;

SET @start_time5 = NOW(3);
	TRUNCATE TABLE bronze.erp_loc_a101 ;
	LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LOC_A101.csv' 
	INTO TABLE bronze.erp_loc_a101 
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n' 
	IGNORE 1 LINES;
SET @end_time5 = NOW(3);

SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time5, @end_time5)/1000,1) as Time_Load_erp_loc_a101;

SET @start_time6 = NOW(3);
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PX_CAT_G1V2.csv' 
	INTO TABLE bronze.erp_px_cat_g1v2
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\r\n' 
	IGNORE 1 LINES;
SET @end_time6 = NOW(3);

SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time6, @end_time6)/1000,1) as Time_Load_erp_px_cat_g1v2;


SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time1, @end_time6)/1000,1) as TotalTime;