/* This query pulls a menu mix of items ordered, BE vs FE, includes order count and 
sales volume by menu item for a defined time range

ONLY pulls orders that are confirmed and paid
Also uses the default menu price in the menu item config*/

Declare @startDate DATE = '2019-12-01'
Declare @endDate DATE = '2019-12-31'

SELECT DISTINCT(oi.menu_item_name) as 'Menu Item', 
a.[Online Orders With Menu Item], 
round(a.[Online Sales Volume],2) as 'Online Sales Volume', 
b.[Backend Orders With Menu Item], 
round(b.[Backend Sales Volume],2) as 'Backend Sales Volume'

FROM msr.order_items oi

JOIN 
(SELECT menu_item_name, count(oi.order_id) as 'Online Orders with Menu Item', sum((quantity * menu_item_price)) as 'Online Sales Volume' 
FROM msr.order_items oi
JOIN (SELECT order_id from msr.orders WHERE order_type = 'order' AND status = 'confirmed' AND paid = 1 AND deleted = 0 AND entered_by = 'online' AND date_reqd BETWEEN @startDate AND @endDate)
o ON oi.order_id = o.order_id
GROUP BY menu_item_name) a ON oi.menu_item_name = a.menu_item_name

JOIN
(SELECT menu_item_name, count(oi.order_id) as 'BackEnd Orders with Menu Item', sum((quantity * menu_item_price)) as 'Backend Sales Volume' FROM msr.order_items oi
JOIN (SELECT order_id from msr.orders WHERE order_type = 'order' AND status = 'confirmed' AND paid = 1 AND deleted = 0 AND entered_by NOT IN ('online') AND date_reqd BETWEEN @startDate AND @endDate)
o ON oi.order_id = o.order_id
GROUP BY menu_item_name) b ON oi.menu_item_name = b.menu_item_name

ORDER BY menu_item_name ASC