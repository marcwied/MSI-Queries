/* This query pulls orders created at 4PM or later, for the following day, with a fulfillment time prior to 12PM*/

SELECT o.order_id as 'Order ID', 
o.order_date as 'Date Created', 
o.order_time as 'Time Created', 
o.date_req as 'Date Required', 
dt.military_time as 'Time Required', 
o.order_subtotal as 'Order Subtotal', 
o.order_total as 'Order Total', 
ad.admin_fname as 'Order Source',
s.store_code as 'Store Code', s.store_name as 'Store Name'

FROM dbo.orders o

JOIN dbo.store s ON o.store_id = s.store_id
JOIN dbo.del_time dt ON o.time_req = dt.del_time_id
JOIN dbo.admin ad ON o.orderby = ad.admin_id

WHERE o.order_type = 1
 AND o.order_status <> 0
 AND DATEPART(dy, CONVERT(varchar,o.date_req)) = DATEPART(dy, CONVERT(varchar,o.order_date)) + 1
 AND o.order_time > 1600
 AND dt.military_time < 1200
 AND order_isdeleted = 0


ORDER BY o.order_id DESC