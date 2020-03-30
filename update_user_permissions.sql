SELECT * FROM dbo.menu_sub where menu_sub_id in (162, 177, 179, 180, 181, 183, 185,187)


/*This query polls current admin_id records for a specified user permission
If it does not have that permission, it will create a new record for that Admin 
and give them that new permission*/

set identity_insert dbo.admin_menu_sub on

INSERT INTO admin_menu_sub

SELECT admin_id, 162
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 162)
and admin_status = 1

INSERT INTO admin_menu_sub

SELECT admin_id, 177
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 177)
and admin_status = 1

INSERT INTO admin_menu_sub

SELECT admin_id, 179
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 179)
and admin_status = 1

INSERT INTO admin_menu_sub

SELECT admin_id, 180
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 180)
and admin_status = 1

INSERT INTO admin_menu_sub

SELECT admin_id, 181
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 181)
and admin_status = 1

INSERT INTO admin_menu_sub

SELECT admin_id, 183
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 183)
and admin_status = 1

INSERT INTO admin_menu_sub

SELECT admin_id, 185
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 185)
and admin_status = 1

INSERT INTO admin_menu_sub

SELECT admin_id, 187
FROM admin
WHERE admin_id NOT IN (SELECT admin_id FROM admin_menu_sub WHERE menu_sub_id = 187)
and admin_status = 1

