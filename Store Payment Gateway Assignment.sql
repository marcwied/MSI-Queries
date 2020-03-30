/* This query pulls store name, code and their PG account information */

SELECT pg.[pgaccount]
      ,pg.[store_code]
      ,store.store_name
  FROM [reports].[PaymentGatewayReconciliation] pg
  JOIN store on pg.store_code = store.store_code
  GROUP BY pgaccount, pg.[store_code], store.store_name
  ORDER BY pgaccount