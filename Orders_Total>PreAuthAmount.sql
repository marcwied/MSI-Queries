/* This query pulls orders for given time range that have an order amount greater than 
the PreAuth amount at the time the original preauth was created */ 

SELECT o.order_id, 
member_fname as 'First Name', 
member_lname as 'Last Name', 
member_email, 
order_date, 
date_req, 
order_subtotal, 
order_gratuity, 
order_total, 
sps.amount as 'PreAuth Amount', 
order_paid, 
order_isDeleted

FROM dbo.orders o

JOIN dbo.secure_payment_seed sps ON o.order_id = sps.order_id
JOIN dbo.member m ON o.member_id = m.member_id

where sps.txntype_id IN (1,6) 
AND sps.isApproved = 1
AND o.order_total > sps.amount
AND m.member_id IN (SELECT member_id from dbo.member 
                WHERE member_email NOT LIKE '%@noemail%'
                AND member_email not like '%@monkeymedia%'
                AND member_email not like '%redrobin%')
AND o.order_id IN ( SELECT order_id  FROM dbo.orders
                    WHERE order_status > 0
                    AND order_date LIKE ('2019%')
                    )
AND o.order_id NOT IN (SELECT order_id from secure_payment_seed where amount = 0) 

ORDER BY o.order_id DESC

