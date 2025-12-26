/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @Start_time DATETIME, @End_time DATETIME
	BEGIN TRY

		PRINT '=============================================================';
		PRINT 'Loading Bronz Layer';
		PRINT '=============================================================';

		Print '-------------------------------------------------------------';
		PRINT 'loading CRM Tables';
		Print '-------------------------------------------------------------';

		SET @Start_time = GETDATE ();
		PRINT '>> Truncating table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info 

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\Yousef_Jabr\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.CSV'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (Second, @Start_time, @End_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		SET @Start_time = GETDATE ();
		PRINT '>> Truncating table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info 
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		from 'C:\Users\Yousef_Jabr\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.CSV'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (Second, @Start_time, @End_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		SET @Start_time = GETDATE ();
		PRINT '>> Truncating table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details 
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		from 'C:\Users\Yousef_Jabr\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.CSV'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (Second, @Start_time, @End_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		Print '-------------------------------------------------------------';
		PRINT 'loading ERP Tables';
		Print '-------------------------------------------------------------';

		SET @Start_time = GETDATE ();
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		from 'C:\Users\Yousef_Jabr\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.CSV'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (Second, @Start_time, @End_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		SET @Start_time = GETDATE ();
		PRINT '>> Truncating table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101 
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		from 'C:\Users\Yousef_Jabr\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.CSV'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (Second, @Start_time, @End_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		SET @Start_time = GETDATE ();
		PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		from 'C:\Users\Yousef_Jabr\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.CSV'
		with (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @End_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (Second, @Start_time, @End_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

	END TRY
	BEGIN CATCH
	PRINT '=============================================================';
	PRINT 'ERROR OCCURE DURING LOADING BRONZE LAYER';
	PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '=============================================================';
	END CATCH

END
