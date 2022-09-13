CREATE TRIGGER `TR1_AFTER_INSERT` AFTER INSERT ON `brewery`
 FOR EACH ROW INSERT INTO brewery_tutorials (brewery_id, tutorial_id)
SELECT 
  NEW.ID,
  id
FROM
  tutorials
/