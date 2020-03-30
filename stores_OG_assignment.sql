--This query pulls stores currently assigned to the default catering order guide
SELECT
    DISTINCT s.store_id,
    s.store_name,
    s.store_code,
    s.store_address_1,
    s.store_address_2,
    s.store_city,
    s.store_zip,
    sog.og_template_id,
    ogb.og_base_id,
	sog.order_type_id AS 'PUP_DEL',
    ogt.og_template_name


FROM dbo.store AS s
JOIN dbo.store_order_guides as sog ON s.store_id=sog.store_id
JOIN dbo.order_guide_template AS ogt ON sog.og_template_id = ogt.og_template_id
JOIN dbo.order_guide_base AS ogb ON ogt.og_template_id = ogb.og_template_id
WHERE ogt.og_template_id = 1