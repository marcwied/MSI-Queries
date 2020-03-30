/* This query adds a new service fee */

SELECT TOP (1000) [order_fee_id]
      ,[order_fee_base_id]
      ,[order_fee_name]
      ,[min_range]
      ,[max_range]
      ,[amount]
      ,[percentage]
      ,[use_min_value]
      ,[order_class_id]
      ,[order_fee_sequence]
      ,[order_fee_del_type]
  FROM [dbo].[order_class_fee]


SELECT * from order_fee_base
SELECT * from order_class_fee

INSERT INTO order_fee_base (order_fee_base_id,order_fee_base_name,order_fee_base_status,order_fee_base_sequence,order_fee_base_is_gratuity,order_fee_base_is_additional_gratuity,order_fee_base_can_edit)
VALUES 
(2,'Full Service Fee',1,2,0,0,0)

INSERT INTO order_class_fee (order_fee_id,order_fee_base_id,order_fee_name,min_range,max_range,amount,percentage,use_min_value,order_class_id,order_fee_sequence,order_fee_del_type)
VALUES 
(6, 2, 'Full Service Fee',0.01,NULL,250,.15,0,2,2,1),
(7, 2, 'Full Service Fee',0.01,NULL,250,.15,0,2,2,0)
