
-- Outputs a Menu Mix report for a given Client ID and a date range
-- Results show Qty and Total of each unique menu item, grouped by Group and Category
-- Results include Category headers, Group headers, Group totals, and Category totals
-- Only menu items of non-Deleted, non-Incomplete Orders are queried

-- Drop temporary table if it exists
IF OBJECT_ID('tempdb..#ResultsTable') IS NOT NULL DROP TABLE #ResultsTable

declare @start_date as varchar(10);
declare @end_date as varchar(10);
declare @client_id as int;

-- Inputs
set @start_date = '2019-01-01';
set @end_date = '2019-05-31';
set @client_id = '151659';

-- Get data into temporary table #ResultsTable
SELECT * INTO #ResultsTable
FROM (
	SELECT oi.menu_item_category_name, oi.menu_item_group_name, oi.menu_item_name AS 'Item_Name', 
		SUM(oi.quantity) AS 'Qty', SUM(oi.quantity*(oi.menu_item_price - oi.item_discount)) AS 'Total',
		CAST(
			ROW_NUMBER() OVER (
				PARTITION BY oi.menu_item_category_name
				ORDER BY oi.menu_item_category_name ASC, oi.menu_item_group_name ASC, oi.menu_item_name ASC
			) 
		AS float) AS [CATEGORY_ROW_NUMBER]
	FROM msr.order_items oi
	LEFT JOIN msr.orders o ON oi.order_id = o.order_id
	WHERE o.[status] != 'incomplete'
		AND o.deleted = 0
		AND o.order_type = 'order'
		AND o.date_reqd >= @start_date
		AND o.date_reqd <= @end_date
		--AND o.store_id = 6
		AND o.client_id = @client_id
	GROUP BY oi.menu_item_category_name, oi.menu_item_group_name, oi.menu_item_name
) x

-- Insert Category headers, Group headers, Group totals, and Category totals
INSERT INTO #ResultsTable 
	-- (Note: Setting CATEGORY_ROW_NUMBER as necessary so that rows appear in the correct order in the final outputted result)
	-- Get Category headers
	SELECT menu_item_category_name, '', CONCAT(menu_item_category_name, ' <c>'), NULL, NULL, 0
	FROM #ResultsTable
	GROUP BY menu_item_category_name
	UNION ALL

	-- Get Group headers
	SELECT menu_item_category_name, menu_item_group_name, CONCAT(menu_item_group_name, ' <g>'), NULL, NULL, MIN([CATEGORY_ROW_NUMBER])-0.1
	FROM #ResultsTable
	GROUP BY menu_item_category_name, menu_item_group_name
	UNION ALL

	-- Get Group totals (only for Categories that have more than 1 Group)
	SELECT menu_item_category_name, menu_item_group_name, '<gt>', SUM([Qty]), SUM([Total]), MAX([CATEGORY_ROW_NUMBER])+0.1
	FROM #ResultsTable
	GROUP BY menu_item_category_name, menu_item_group_name
	UNION ALL

	-- Get Category totals
	SELECT menu_item_category_name, '', '<ct>', SUM([Qty]), SUM([Total]), MAX([CATEGORY_ROW_NUMBER])+0.2
	FROM #ResultsTable
	GROUP BY menu_item_category_name

-- Output results
--SELECT menu_item_category_name, menu_item_group_name, [Item_Name], ISNULL(CAST([Qty] AS varchar), ''), ISNULL(CAST(CONVERT(DECIMAL(10,2), [Total]) AS varchar), ''), [CATEGORY_ROW_NUMBER]
SELECT [Item_Name], ISNULL(CAST([Qty] AS varchar), '') AS 'Qty', ISNULL(CAST(CONVERT(DECIMAL(10,2), [Total]) AS varchar), '') AS 'Total'
FROM #ResultsTable
ORDER BY menu_item_category_name ASC, 
	[CATEGORY_ROW_NUMBER] ASC