/* This query pulls driver_id from dbo.driver that have first name like "doordash"
and assigns those drivers to the DD Drive Service */

INSERT INTO driver_party_properties
SELECT driver_id, 8, 'doordash_default'
FROM dbo.driver
WHERE driver_fname LIKE ('%doordash%')