/* This query pulls client information and order count from their preferred store */

SELECT cl.client_id AS 'Client_ID',
 cl.first_name AS 'First_Name',
 cl.last_name AS 'Last_Name',
 cl.email_address AS 'Email_Address',
 cl.phone_number AS 'Phone_Number',
 cl.address1 AS 'Address_1',
 cl.address2 AS 'Address_2',
 cl.city AS 'City',
 cl.[state] AS 'State',
 cl.zip_code AS 'Zip_Code',
 cl.company_name AS 'Company',
 cl.marketing_group AS 'Marketing_Group',
 cl.account_id AS 'Billing_Account_ID',
 cl.account_name AS 'Billing_Account_Name',
 s.store_code AS 'Preferred_Store_Code',
 cl.preferred_region_store_name AS 'Preferred_Region_Store_Name',
 o.Order_Count,
 o.Last_Order_Date
 
FROM msr.clients_and_leads cl

 LEFT JOIN msr.stores s ON cl.preferred_store_id = s.store_id
 LEFT JOIN (
 SELECT client_id, COUNT(order_id) AS 'Order_Count', CONVERT(VARCHAR(10), MAX(date_reqd), 120) AS 'Last_Order_Date'
 FROM msr.orders
 WHERE [status] = 'confirmed'
 AND deleted = 0
 AND order_type = 'order'
 GROUP BY client_id
 ) o ON cl.client_id = o.client_id
 
WHERE cl.is_lead = 0
 AND cl.email_address NOT LIKE '%monkeymedia%'
 AND cl.[status] = 'Active'
 AND cl.is_deleted = 0