/* This query pulls client information for clients that havent ordered within the defined Date Range.
	it also includes the order date of the last order placed prior to Date Range, and same for first order placed after Date Range*/

Declare @parDate DATE = '2018-08-16' 				   -- Defines variable for "Ending Date" of the Date Range
Declare @startDate DATE = DATEADD(day, -120, @parDate) -- Defines variable for "Beginning Date" of the Date Range by subtracting 120 days from "Ending Date"

SELECT cl.client_id as 'Client ID', 
cl.first_name as' First Name', 
cl.last_name as 'Last Name', 
cl.email_address as 'Email Address', 
cl.phone_number as 'Phone Number', 
os.last_before_range as 'Last Order Prior to Beginning Date of Range', 
ro.first_after_range as 'First Order After the Ending Date of Range'

FROM msr.clients_and_leads cl

-- Selects clients and their last order placed prior to "Beginning Date" of Range
JOIN (
    SELECT o.client_id, MAX(o.order_date) AS last_before_range
    from msr.orders o
    WHERE o.[status] = 'confirmed'
		AND o.deleted = 0
		AND o.order_type = 'order'
    AND o.order_date < @startDate
        GROUP BY o.client_id
        )os ON cl.client_id = os.client_id
        
-- Selects clients and their first order placed after the "Ending Date" of Range        
JOIN (
    SELECT o.client_id, MIN(o.order_date) AS first_after_range
    from msr.orders o
    WHERE o.[status] = 'confirmed'
		AND o.deleted = 0
		AND o.order_type = 'order'
    AND o.order_date >= @parDate
        GROUP BY o.client_id
        )ro ON os.client_id = ro.client_id
        
        
/* Filters for clients that are active, not deleted, dont have monkey email and havent placed an order within the Defined Date Range */        
WHERE cl.[status] = 'Active'
	AND cl.is_deleted = 0
	AND cl.email_address NOT LIKE '%@monkeymediasoftware.com%'
	AND cl.client_id NOT IN (select client_id from msr.orders o where order_date between @startDate and @parDate GROUP BY client_id)