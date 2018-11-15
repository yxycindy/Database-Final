---1 Given user ID, List all the climbs(including climb name, crag, country, 
--and climb grade(US form), send method) the user has done, sort by increasing difficulty level 

SELECT ascent.name, ascent.crag, ascent.country, grade.usa_routes, method.name
FROM ascent
INNER JOIN grade ON ascent.grade_id = grade.id
INNER JOIN method ON ascent.method_id = method.id
WHERE ="23"
ORDER BY grade_id 


--3 Given a country code, list all the climer ID, gender of the people who climbed something harder than 5.14

SELECT DISTINCT user.id, gender.sex_name
FROM ascent 
INNER JOIN user ON ascent.user_id = user.id
INNER JOIN gender ON user.sex = gender.sex
WHERE user.country = "SWE" AND ascent.grade_id >= 68

--10 List the top three country that has most female climbers in the database, include the number

SELECT user.country, COUNT(user.id)
FROM user
WHERE user.sex = 1 
GROUP BY user.country
LIMIT 3 