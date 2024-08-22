
SET
@Entry = 290011,
@Name = "Линг",
@Title = "Банкир реагентов";

DELETE FROM `creature_template_locale` WHERE `entry` = @Entry;

INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (@Entry, 'ruRU', @Name, @Title, NULL);
