/*This query currently pulls client name, a count of orders w/ a beverage, 
Total sales of orders that contain a beverage, and count of individual beverages ordered by the client*/


SELECT o.client_name as 'Client Name', 
count(DISTINCT(o.order_id)) as 'Orders w/Beverage', 
sum(DISTINCT(o.total)) as 'Sales containing beverages', 
SUM(oi.quantity) as 'Number of Beverages'

 FROM msr.orders o
 
 JOIN msr.order_items oi ON oi.order_id = o.order_id
 
 WHERE order_type = 'order' 
 AND status = 'confirmed' 
 AND paid = 1 
 AND deleted = 0 
 AND menu_item_category_name = 'Beverages'
 
 GROUP BY o.client_name
 
 ORDER BY [Sales containing beverages] DESC


