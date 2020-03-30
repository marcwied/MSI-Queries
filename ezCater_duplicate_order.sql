/*This query pulls duplicate ezCater orders in MSI */

SELECT ezcater_order_id, 
count(*) as 'Number of orders in MONKEY', 
order_date, 
date_reqd

FROM msr.orders

WHERE order_type = 'order' 
AND status != 'abandoned'
and ezcater_order_id is not NULL
and ezcater_order_id != '' 
GROUP BY ezcater_order_id, order_date, date_reqd

HAVING COUNT(*) > 1
  
order by order_date desc