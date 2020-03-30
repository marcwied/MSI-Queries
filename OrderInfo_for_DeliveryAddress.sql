/*This query pulls order count and sales sum ($) for chosen delivery address in a specified date range */

DECLARE @startDate DATE = '2019-01-01'
DECLARE @endDate DATE = '2019-12-31'
DECLARE @address VARCHAR(50) = '%4103 North Military Trail%'
DECLARE @city VARCHAR(50) = 'Boca Raton'
DECLARE @state VARCHAR(10) = 'FL'
DECLARE @postal int = 33431

SELECT count(DISTINCT[order_id]) as "Count of Orders for Address",
sum(total) as "Sum of Orders for Address "

FROM [msr].[orders]

WHERE [status] = 'confirmed'
AND deleted = 0
AND order_type = 'order'
AND del_address_1 LIKE @address
AND del_city = @city
AND del_state = @state
AND del_postal = @postal
AND date_reqd BETWEEN @startDate AND @endDate