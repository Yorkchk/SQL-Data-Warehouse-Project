SET SESSION sql_mode = '';
SET @start_time1 = NOW(3);
	TRUNCATE TABLE names_info.cust_name_table;
	LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/names_info.csv' 
	INTO TABLE names_info.cust_name_table 
	FIELDS TERMINATED BY ',' 
	ENCLOSED BY '"' 
	LINES TERMINATED BY '\n' 
	IGNORE 1 LINES;
SET @end_time1 = NOW(3);

SELECT ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time1, @end_time1)/1000,1) as Time_Load_cust_name_table; 


SELECT *
FROM names_info.cust_name_table;