/* This query pulls a list of Active Stores that have not received an order within a specified time period */

select store_name, store_code

from msr.stores

where status = 'Active' AND store_id NOT IN(select store_id from msr.orders 
where order_date BETWEEN '2019-11-01' AND '2019-12-30' AND status = 'confirmed' AND deleted = 0)