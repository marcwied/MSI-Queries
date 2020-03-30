/* This query pulls orders fulfilled in 2018-2019, sums the order total by Marketing Group*/ 



SELECT a.marketing_group, sum(o.total) as '2018/2019 Sales for Group'

FROM moes_monkeysee.msr.accounts a 

JOIN msr.orders o ON a.account_id = o.billing_id

WHERE date_reqd >= 2018-01-01 OR date_reqd <= 2019-12-31
AND order_type = 'order' 
AND o.status = 'confirmed' 
AND paid = 1 
AND deleted = 0

GROUP BY a.marketing_group

