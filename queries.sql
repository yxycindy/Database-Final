# This is the final project of
# Yaxi Hu, JHUID: yhu53
# Xingyi Yang, JHUID: xyang73



---1 Given user ID, List all the climbs(including climb name, crag, country,
--and climb grade(US form), send method) the user has done, sort by increasing difficulty level
delimiter //
DROP PROCEDURE IF EXISTS ListClimb //
CREATE PROCEDURE ListClimb(IN ID VARCHAR(4))
BEGIN
IF EXISTS(SELECT id FROM user WHERE id=ID) THEN
  SELECT ascent.name, ascent.crag, ascent.country, ascent.year, grade.usa_routes, method.name
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN method ON ascent.method_id = method.id
  WHERE ascent.user_id=ID AND ascent.climb_type = 0
  ORDER BY ascent.grade_id;
ELSE
  SELECT 'ERROR: ', 'Incorrect ID' as 'Result';
END IF;
END;
//
delimiter;

--2. Given user ID, List all the boulder problems(including climb name, crag, country,
--and climb grade(US form), send method, year) the user has done, sort by increasing difficulty level
delimiter //
DROP PROCEDURE IF EXISTS ListBoulder //
CREATE PROCEDURE ListBoulder(IN ID VARCHAR(4))
BEGIN
IF EXISTS(SELECT id FROM user WHERE id=ID) THEN
  SELECT ascent.name, ascent.crag, ascent.year, ascent.country, grade.usa_boulders, method.name
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN method ON ascent.method_id = method.id
  WHERE ascent.user_id=ID AND ascent.climb_type = 1
  ORDER BY ascent.grade_id;
ELSE
  SELECT 'ERROR: ', 'Incorrect ID' as 'Result';
END IF;
END;
//
delimiter;

--3 Given a country code, list all the climer ID, gender of the people who
--climbed something harder than 5.14
delimiter //
DROP PROCEDURE IF EXISTS List514 //
CREATE PROCEDURE List514(IN countryID VARCHAR(4))
BEGIN
IF EXISTS(SELECT country FROM ascent WHERE country=countryID) THEN
  SELECT DISTINCT user.id, gender.name as sex
  FROM ascent
  INNER JOIN user ON ascent.user_id = user.id
  INNER JOIN gender ON user.sex = gender.gID
  WHERE user.country = countryID AND ascent.grade_id >= 68 AND ascent.climb_type = 0;
ELSE
  SELECT 'ERROR: ', 'Incorrect country code' as 'Result';
END IF;
END;
//
delimiter;

--4. For every country in the database, calculate
--the total number of climbers who has climbed something harder than 5.12.
delimiter //
DROP PROCEDURE IF EXISTS TOP512 //
CREATE PROCEDURE TOP512()
BEGIN
  SELECT DISTINCT ascent.country, COUNT(ascent.user_id) as num
  FROM ascent
  INNER JOIN user ON ascent.user_id = user.id AND ascent.climb_type = 0
  WHERE ascent.grade_id >= 51
  GROUP BY ascent.country
  ORDER BY num DESC;
END;
//
delimiter;

--5. Given a country code list top 5 most popular crags,
delimiter //
DROP PROCEDURE IF EXISTS Popular //
CREATE PROCEDURE Popular(IN countryID VARCHAR(4))
BEGIN
IF EXISTS(SELECT country FROM ascent WHERE country=countryID) THEN
  SELECT ascent.crag, COUNT(ascent.id) as num
  FROM ascent
  WHERE ascent.country = countryID
  GROUP BY ascent.crag
  ORDER BY num DESC
  LIMIT 5;
ELSE
  SELECT 'ERROR: ', 'Incorrect country code' as 'Result';
END IF;
END;
//
delimiter;

--6.Given a specific climbing grade  range in USA grading system
--(e.g. 5.9-5.10, 5.10-5.11, 5.11-5.12, 5.12-5.13 … ),
--list the number of climbs in each country that’s at that grade,
--sort in descending order.
delimiter //
DROP PROCEDURE IF EXISTS ListClimb_GradeNum //
CREATE PROCEDURE ListClimb_GradeNum(IN low VARCHAR(4), In high VARCHAR(4))
BEGIN
IF EXISTS(SELECT id FROM grade WHERE id=low) THEN
  SELECT ascent.country, COUNT(DISTINCT ascent.id) as numOfClimb
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  WHERE grade.id <= high AND grade.id > low AND ascent.climb_type = 0
  GROUP BY ascent.country
  ORDER BY numOfClimb DESC;
ELSE
  SELECT 'ERROR: ', 'Incorrect grade' as 'Result';
END IF;
END;
//
delimiter;

--7.	Given specific year List the male ID who climbed the highest
--number of routes that’s harder than 5.15a, include all the climbs
--they have done that year as well as the climbs name, crag, sector,
--country, and grade.
delimiter //
DROP PROCEDURE IF EXISTS HardestClimb_male //
CREATE PROCEDURE HardestClimb_male(IN YEAR VARCHAR(4))
BEGIN
IF EXISTS(SELECT year FROM ascent WHERE year=YEAR) THEN
  SELECT user.id, ascent.year, ascent.name, ascent.crag, ascent.sector,
  ascent.country, grade.usa_routes
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN user ON ascent.user_id = user.id
  WHERE grade.id > 76 AND ascent.year=YEAR AND user.id IN
  (SELECT x.id
  FROM
  (SELECT user.id, COUNT(ascent.id) as numOfClimb
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN user ON ascent.user_id = user.id
  WHERE ascent.year=YEAR AND user.sex = 0 AND grade.id > 76 AND ascent.climb_type = 0
  GROUP BY user.id
  ORDER BY numOfClimb DESC
  LIMIT 1) as x);
ELSE
  SELECT 'ERROR: ', 'Incorrect year' as 'Result';
END IF;
END;
//
delimiter;


--8.	Given specific year List the female ID who climbed the highest
--number of routes that’s harder than 5.14a, include all the climbs
--they have done that year as well as the climbs name, crag, sector,
--country, and grade.
delimiter //
DROP PROCEDURE IF EXISTS HardestClimb_female //
CREATE PROCEDURE HardestClimb_female(IN YEAR VARCHAR(4))
BEGIN
IF EXISTS(SELECT year FROM ascent WHERE year=YEAR) THEN
  SELECT user.id, ascent.year, ascent.name, ascent.crag, ascent.sector,
  ascent.country, grade.usa_routes
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN user ON ascent.user_id = user.id
  WHERE grade.id > 67 AND ascent.year=YEAR AND user.id IN
  (SELECT x.id
  FROM
  (SELECT user.id, COUNT(ascent.id) as numOfClimb
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN user ON ascent.user_id = user.id
  WHERE ascent.year=YEAR AND user.sex = 1 AND grade.id > 67 AND ascent.climb_type = 0
  GROUP BY user.id
  ORDER BY numOfClimb DESC
  LIMIT 1) as x);
ELSE
  SELECT 'ERROR: ', 'Incorrect year' as 'Result';
END IF;
END;
//
delimiter;

--9.	List the top 10 country in the world that has
--most female climbers who achieved the grade 5.13 in the database
delimiter //
DROP PROCEDURE IF EXISTS Topfemale //
CREATE PROCEDURE Topfemale()
BEGIN
  SELECT DISTINCT user.country, COUNT(ascent.user_id) as num
  FROM user
  INNER JOIN ascent ON user.id = ascent.user_id
  INNER JOIN grade ON ascent.grade_id = grade.id
  WHERE user.sex = 1 AND grade.id > 59 AND ascent.climb_type = 0
  GROUP BY user.country
  ORDER BY num DESC
  LIMIT 10;
END;
//
delimiter;

--10. List the top 10 crags in the world that contains the
--most number of hardest climb(climbs rated higher than 5.15)
-- including the country code for each crack
delimiter //
DROP PROCEDURE IF EXISTS Top_crack //
CREATE PROCEDURE Top_crack()
BEGIN
  SELECT DISTINCT ascent.crag, ascent.country, COUNT(ascent.id) as num
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  WHERE grade.id > 76 AND ascent.climb_type = 0
  GROUP BY ascent.crag
  ORDER BY num DESC
  LIMIT 10;
END;
//
delimiter;

--11. Given a specific climbing grade range in USA grading system
--(e.g. 5.9-5.10, 5.10-5.11, 5.11-5.12, 5.12-5.13 … ),
--list the number of men and women each country that’s at that grade,
--sort in descending order.
delimiter //
DROP PROCEDURE IF EXISTS ListClimb_Grade //
CREATE PROCEDURE ListClimb_Grade(IN low VARCHAR(4), In high VARCHAR(4))
BEGIN
IF EXISTS(SELECT id FROM grade WHERE id=low) THEN
  SELECT x.country, x.numOfmen, y.numOfgirl
  FROM
  (SELECT user.country, COUNT(DISTINCT ascent.user_id) as numOfmen
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN user ON  ascent.user_id = user.id
  WHERE grade.id <= high AND grade.id > low AND user.sex = 0 AND ascent.climb_type = 0
  GROUP BY user.country
  ORDER BY numOfmen DESC) as x
  LEFT OUTER JOIN
  (SELECT user.country, COUNT(DISTINCT ascent.user_id) as numOfgirl
  FROM ascent
  INNER JOIN grade ON ascent.grade_id = grade.id
  INNER JOIN user ON  ascent.user_id = user.id
  WHERE grade.id <= high AND grade.id > low AND user.sex = 1 AND ascent.climb_type = 0
  GROUP BY user.country
  ORDER BY numOfgirl DESC) as y
  ON x.country = y.country;
ELSE
  SELECT 'ERROR: ', 'Incorrect grade range' as 'Result';
END IF;
END;
//
delimiter;

--12. Given user ID, count the number of climbs
--that the user has done for each send method(on-sight, flash, red-point)
delimiter //
DROP PROCEDURE IF EXISTS CountMethod //
CREATE PROCEDURE CountMethod(IN ID VARCHAR(4))
BEGIN
IF EXISTS(SELECT id FROM user WHERE id=ID) THEN
  SELECT method.name, count(ascent.user_id) as numOfClimb
  FROM ascent
  INNER JOIN method ON ascent.method_id = method.id
  WHERE ascent.user_id=ID AND ascent.climb_type = 0
  GROUP BY method.id;
ELSE
  SELECT 'ERROR: ', 'Incorrect ID' as 'Result';
END IF;
END;
//
delimiter;

--13. Given user ID, count the number of boulder problems
--that the user has done for each send method(on-sight, flash, red-point)
delimiter //
DROP PROCEDURE IF EXISTS CountMethodBoulder //
CREATE PROCEDURE CountMethodBoulder(IN ID VARCHAR(4))
BEGIN
IF EXISTS(SELECT id FROM user WHERE id=ID) THEN
  SELECT method.name, count(ascent.id)
  FROM ascent
  INNER JOIN method ON ascent.method_id = method.id
  WHERE ascent.user_id=ID AND ascent.climb_type = 1
  GROUP BY method.id;
ELSE
  SELECT 'ERROR: ', 'Incorrect ID' as 'Result';
END IF;
END;
//
delimiter;


--14. List top 10 climber ID that has done most number of the hardest climb
--in the world (climbs that’s harder than 5.15),
--include their gender, country, and number of climbs.
delimiter //
DROP PROCEDURE IF EXISTS Top_Climb//
CREATE PROCEDURE Top_Climb()
BEGIN
  SELECT DISTINCT user.id, gender.name, user.country, COUNT(ascent.id) as num
  FROM user
  INNER JOIN gender ON user.sex = gender.gID
  INNER JOIN ascent ON user.id = ascent.user_id
  INNER JOIN grade ON ascent.grade_id = grade.id
  WHERE grade.id > 76 AND ascent.climb_type = 0
  GROUP BY user.id
  ORDER BY num DESC
  LIMIT 10;
END;
//
delimiter;


--15. List top 10 climber ID that has done most number of the hardest boulder problems
--in the world (boulders that’s harder than V12),
--include their gender, country, and number of climbs.
delimiter //
DROP PROCEDURE IF EXISTS Top_Boud//
CREATE PROCEDURE Top_Boud()
BEGIN
  SELECT DISTINCT user.id, gender.name, user.country, COUNT(ascent.id) as num
  FROM user
  INNER JOIN gender ON user.sex = gender.gID
  INNER JOIN ascent ON user.id = ascent.user_id
  INNER JOIN grade ON ascent.grade_id = grade.id
  WHERE grade.id > 70 AND ascent.climb_type = 1
  GROUP BY user.id
  ORDER BY num DESC
  LIMIT 10;
END;
//
delimiter;
