
ALTER TABLE `custom_reagent_bank`
ADD COLUMN `account_id` int(11) NOT NULL DEFAULT 0 FIRST;

UPDATE `custom_reagent_bank` rb INNER JOIN `characters` c ON c.guid = rb.character_id SET rb.account_id = c.account;
