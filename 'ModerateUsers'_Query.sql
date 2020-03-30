/* This query pulls client name, email, mailing information, and lifetime order count
 for clients that have placed their first Order OUTSIDE the past 90 days, and have 2-4 times
 within the past 365 days, from the date the query is run.
 does not include deleted orders, quotes, clients not opted into mailing list, or clients with 'noemail' contained in their
 email address*/

select first_name as 'First Name', 
last_name as 'Last Name', 
email_address as 'Email Address', 
city as 'City', 
state as 'State', 
zip_code as 'Zip Code', 
(COUNT(DISTINCT(o.order_id))) as 'Lifetime Orders'

from msr.clients_and_leads cl

JOIN msr.orders o ON cl.client_id = o.client_id

where on_mailing_list = 1
AND o.deleted = 0
AND o.order_type = 'Order'
AND cl.email_address NOT LIKE('%noemail%')
AND o.status <> 'Incomplete'


GROUP BY first_name, last_name, email_address, city, state, zip_code

HAVING (MIN(o.date_reqd)) < GETDATE() - 90
AND (MAX(o.date_reqd)) >= GETDATE() - 365
AND (count(o.order_id)) BETWEEN 2 AND 4