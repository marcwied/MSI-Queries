 SELECT DISTINCT
 cl.client_id as 'Member ID',
 cl.first_name as 'First Name',
 cl.last_name as 'Last Name',
 cl.email_address as 'email',
 cl.phone_number as 'Phone',
 b.company_name as 'Billing Account',
 cl.loyalty_rewards_account as 'Loyalty Number',
 cl.date_added as 'Date Registered',
 AVG(o.total) as 'AVG Order$',
 COUNT(DISTINCT(o.order_id)) as 'Total Orders within TimeFrame',
 SUM(o.total) as 'Orders Value Total',
 MAX(o.date_reqd) AS 'Last Order Date',
 e.order_id as 'Last Order ID',
 e.total as 'Last Order $',
 e.store_id as 'Last Store ID'
 

FROM msr.clients_and_leads as cl

JOIN msr.orders as o on cl.client_id = o.client_id
JOIN msr.accounts b ON cl.account_id = b.account_id
--PULLS CLIENT ID / Order Total / Order Date FOR THE MOST RECENT ORDER AND ADDS THEM TO ALIAS e
JOIN (SELECT o.client_id, o.total, o.order_date, o.order_id, o.store_id
		FROM msr.orders o
	--THIS NEXT JOIN LOCATES THE MOST RECENT ORDER
		 JOIN (SELECT o.client_id, max(o.order_id) as order_id from msr.orders o WHERE o.status <> 'incomplete'  AND o.deleted = 0 AND o.order_type = 'order'
		 AND o.date_reqd BETWEEN '20190305' AND '20200305'
		 AND o.store_id in (SELECT store_id from msr.stores s where 
                            --s.store_code in ()
                            s.region_name in ('Test Region', 'CO - CO Springs - Nastos')
                            --s.store_id in (1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
			                -- 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58,
			                -- 59, 60, 102, 108,109,219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 369, 370, 372, 375, 376, 415,
			                -- 663, 665, 666, 667, 668)
                            )
         
         
          
		group by o.client_id) as A on o.order_id = a.order_id) as e ON cl.client_id = e.client_id

WHERE 

cl.client_id IN (SELECT client_id from msr.clients_and_leads cl WHERE cl.email_address not like '%@monkeymedia%')
AND o.order_id IN (SELECT order_id FROM msr.orders o
		WHERE o.status <> 'incomplete' AND o.deleted= 0 and o.order_type = 'order'
		AND o.date_reqd BETWEEN '20190305' AND '20200305'
		 AND o.store_id in (SELECT store_id from msr.stores s where 
                            --s.store_code in ()
                            s.region_name in ('Test Region', 'CO - CO Springs - Nastos')
                            --s.store_id in (1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
			                --  29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58,
			                --  59, 60, 102, 108,109,219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 369, 370, 372, 375, 376, 415,
			                --  663, 665, 666, 667, 668)
                            )
                            )

GROUP BY cl.client_id,
 cl.first_name,
 cl.last_name,
 cl.email_address,
 cl.phone_number,
 cl.date_added,
 b.company_name,
 e.total,
 cl.loyalty_rewards_account,
 e.order_id,
 e.total,
 e.store_id

 --HAVING COUNT(o.order_id) between 2 and 4
 
 ORDER BY b.company_name ASC