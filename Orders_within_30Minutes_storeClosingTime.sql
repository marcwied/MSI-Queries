/* This query pulls orders that have a fulfillment time 30 minutes or less to the store closing time, for the day of the order */

SELECT DATEPART(weekday, CONVERT(varchar,o.date_req)) as 'Day of Order', 
dtt.military_time AS [order_reqd_time], 
dtt2.military_time AS [store_end_time], 
(dtt2.military_time - dtt.military_time) AS [time_diff], 
s.store_code as 'Store Code', 
s.store_name as 'Store Name', 
o.order_id as 'Order ID', 
o.order_date as 'Date Order Placed', 
order_time as 'Time Order Placed', 
date_req as 'Date Order Required', 
ad.admin_username as 'Order Source', 
o.order_subtotal as 'Order Sub Total', 
o.order_total as 'Order Total', 
order_isDeleted as 'Deleted?'

FROM dbo.orders o

 LEFT JOIN dbo.del_time_togo dtt ON o.time_req = dtt.del_time_id
 LEFT JOIN dbo.store s ON o.store_id = s.store_id
 LEFT JOIN dbo.ordering_time ot ON s.ordering_time_template_id = ot.template_id
 LEFT JOIN dbo.del_time_togo dtt2 ON ot.end_time_id = dtt2.del_time_id
 LEFT JOIN dbo.admin ad ON o.orderBy = ad.admin_id

 WHERE (dtt2.military_time - dtt.military_time) <= 30 
 AND o.del_type = 0
 AND o.order_type = 1
 AND o.isToGoOrder = 1
 AND o.date_req BETWEEN 20191222 AND 20200122
 AND o.order_status <> 0
 AND DATEPART(weekday, CONVERT(varchar,o.date_req)) = ot.day_id
 
 order by o.store_id desc