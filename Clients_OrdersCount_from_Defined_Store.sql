/*Pulls client information and a count of orders from a defined store and time frame */

SELECT c.client_id as 'Client ID', 
c.first_name as' First Name', 
c.last_name as 'Last Name', 
c.email_address as 'Email Address', 
c.phone_number as 'Phone Number', 
c.date_added as 'Date Registered', 
o.order_count as 'Orders placed at Store'

FROM msr.clients_and_leads c

LEFT JOIN (
 SELECT client_id, COUNT(order_id) AS order_count
 FROM msr.orders
 WHERE store_id = 9
  AND ([status] = 'confirmed' OR [status] = 'unconfirmed')
  AND deleted = 0
  AND order_type = 'order'
  AND date_reqd > '20190101'
 GROUP BY client_id
) o ON c.client_id = o.client_id

WHERE o.order_count IS NOT NULL
 AND o.order_count > 0

 SELECT * from msr.stores
 where store_id = 9