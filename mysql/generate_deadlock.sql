CREATE TABLE `table1` ( `id` INT NOT NULL AUTO_INCREMENT, `name` VARCHAR(255) NOT NULL, `marks` INT NOT NULL, PRIMARY KEY (`id`) ) ENGINE=InnoDB;
INSERT INTO table1 (id, name, marks) VALUES (1, "abc", 5);
INSERT INTO table1 (id, name, marks) VALUES (2, "xyz", 1);

-- First Window
BEGIN;
UPDATE table1 SET marks=marks-1 WHERE id=1; -- X lock acquired on 1

-- Second Window
BEGIN;
UPDATE table1 SET marks=marks+1 WHERE id=2; -- X lock acquired on 2
UPDATE table1 SET marks=marks-1 WHERE id=1; -- LOCK WAIT!

-- First Window (continued)
UPDATE table1 SET marks=marks+1 WHERE id=2; -- DEADLOCK!
COMMIT;
