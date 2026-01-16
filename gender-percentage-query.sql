SELECT *,
CONCAT(ROUND((gender_count * 100.00 / (SELECT COUNT(*) FROM employees2) ), 2), "%") AS percentage
FROM(
SELECT 
gender,
COUNT(*) AS gender_count
FROM employees2
GROUP BY gender
) AS t