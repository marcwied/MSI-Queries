/*This query adds a new final payment method */

SELECT * FROM payment_method

SET IDENTITY_INSERT [payment_method] ON
GO

INSERT INTO [payment_method]
([payment_method_id]
,[payment_method_name]
,[isCreditCard]
,[promo_payment_method]
,[store_can_apply]
,[payment_method_status])
SELECT MAX(payment_method_id)+1,'EZ Delivery',0,0,1,1
FROM payment_method
WHERE payment_method_id < 100
GO

SET IDENTITY_INSERT [payment_method] OFF
GO