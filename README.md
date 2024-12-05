# Reagent Guild Bank

An AzerothCore module for adding a reagent bank NPC for the guild.

## Notes

I wanted to do this as simply as possible.  I cloned the mod that creates a reagent banker NPC that works for the player's account, and I just replaced all the IDs with the guild id.

```
// find
player->GetSession()->GetAccountId()

// replace
player->GetGuildId()
```

Then I ran this MySQL script to combine all the items into condensed rows:

```
-- SQL Script to Update custom_reagent_bank_account Table

-- Step 1: Create a Temporary Table
CREATE TEMPORARY TABLE temp_reagent_bank_account (
    account_id INT(11) NOT NULL,
    item_entry INT(11) NOT NULL,
    item_subclass INT(11) NOT NULL,
    amount INT(11) NOT NULL
);

-- Step 2: Insert Aggregated Data
INSERT INTO temp_reagent_bank_account (account_id, item_entry, item_subclass, amount)
SELECT
    2 AS account_id,
    item_entry,
    item_subclass,
    SUM(amount) AS amount
FROM
    custom_reagent_bank_account
GROUP BY
    item_entry,
    item_subclass;

-- Step 3: Delete Original Rows
DELETE FROM custom_reagent_bank_account;

-- Step 4: Insert Deduplicated Rows Back
INSERT INTO custom_reagent_bank_account (account_id, item_entry, item_subclass, amount)
SELECT account_id, item_entry, item_subclass, amount
FROM temp_reagent_bank_account;

-- Optional: Clean Up (if using a regular table)
-- DROP TABLE IF EXISTS temp_reagent_bank_account; -- Uncomment if using a regular table
```

You will need to replace ``2`` with the proper guild id for your server.

## Warnings

For whatever reason, you have to have this mod installed at ``modules/mod-reagent-bank-account/`` or it won't compile.