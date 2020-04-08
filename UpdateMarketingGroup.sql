
/* Update Billing Accounts */

UPDATE dbo.billing
SET billing_group = 70
where billing_group IN (110, 111, 109)

UPDATE dbo.billing
SET billing_group = 78
where billing_group IN (73, 105, 41, 96, 104)

UPDATE dbo.billing
SET billing_group = 98
where billing_group = 81

UPDATE dbo.billing
SET billing_group = 82
where billing_group = 64

UPDATE dbo.billing
SET billing_group = 70
where billing_group IN (110, 111, 109)

UPDATE dbo.billing
SET billing_group = 103
where billing_group IN (93, 95)

UPDATE dbo.billing
SET billing_group = 6460
where billing_group IN (74, 68)


/* Update Client Accounts */

UPDATE dbo.member
SET account_group_id = 70
where account_group_id IN (110, 111, 109)

UPDATE dbo.member
SET account_group_id = 78
where account_group_id IN (73, 105, 41, 96, 104)

UPDATE dbo.member
SET account_group_id = 98
where account_group_id = 81

UPDATE dbo.member
SET account_group_id = 82
where account_group_id = 64

UPDATE dbo.member
SET account_group_id = 70
where account_group_id IN (110, 111, 109)

UPDATE dbo.member
SET account_group_id = 103
where account_group_id IN (93, 95)

UPDATE dbo.member
SET account_group_id = 6460
where account_group_id IN (74, 68)