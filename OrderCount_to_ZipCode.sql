/* This query pulls a number of orders delivered to a specified zip in a specified time range */

DECLARE @startDate DATE = '2019-01-01'
DECLARE @endDate DATE = '2019-12-31'
DECLARE @postal int = 98043

SELECT count(DISTINCT[order_id]) as "Count of Orders for Zip Code"

FROM [msr].[orders]

WHERE [status] = 'confirmed'
AND deleted = 0
AND order_type = 'order'
AND del_postal = @postal
AND date_reqd BETWEEN @startDate AND @endDate
  