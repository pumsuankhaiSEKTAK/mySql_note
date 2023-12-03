
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

it means that the 'ONLY_FULL_GROUP_BY' setting was not present in the sql_mode to begin with, or it was successfully removed.
