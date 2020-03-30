/* This query pulls client and order count within a time frame for clients that DO have loyalty setup*/



  SELECT DISTINCT
 m.member_id,
 m.member_fname,
 m.member_lname,
 m.member_email,
 m.member_phone,
 mls.auth_token,
 mls.added_on,
 COUNT(DISTINCT(order_id)) as 'Total Orders within TimeFrame'

FROM member_loyalty_subscription as mls

JOIN orders as o on mls.member_id = o.member_id
JOIN member as m on mls.member_id = m.member_id

WHERE 
 o.order_status>0
 AND o.order_date BETWEEN 20180110 AND 20190929
AND o.order_isDeleted=0
AND m.member_email not like '%monkeymedia%'

GROUP BY m.member_id,
 m.member_fname,
 m.member_lname,
 m.member_email,
 m.member_phone,
 mls.auth_token,
 mls.added_on
