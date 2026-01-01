-- 12.Which are the 3 most popular and 3 least popular painting styles?
SELECT 'Most_Popular_Style' AS Top_3 , style, No_Of_Style, RankStyle, RankStyle2
FROM(
SELECT 
COALESCE(NULLIF(TRIM(style), ''), 'UNKNOWN') AS style,
COUNT(*) AS No_Of_Style,
ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS RankStyle,
ROW_NUMBER() OVER (ORDER BY COUNT(*) ASC) AS RankStyle2
FROM work
GROUP BY style																						-- without CTE
ORDER BY COUNT(*) DESC
) AS t
WHERE RankStyle <= 3

UNION ALL

SELECT 'Least_Popular_Style' AS Top_3 , style, No_Of_Style, RankStyle, RankStyle2
FROM(
SELECT 
COALESCE(NULLIF(TRIM(style), ''), 'UNKNOWN') AS style,
COUNT(*) AS No_Of_Style,
ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS RankStyle,
ROW_NUMBER() OVER (ORDER BY COUNT(*) ASC) AS RankStyle2
FROM work
GROUP BY style
ORDER BY COUNT(*) DESC
) AS t
WHERE RankStyle2 <= 3;




WITH CTE_Style AS (
SELECT 
COALESCE(NULLIF(TRIM(style), ''), 'UNKNOWN') AS style,
COUNT(*) AS No_Of_Style,
ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS RankStyle,
ROW_NUMBER() OVER (ORDER BY COUNT(*) ASC) AS RankStyle2
FROM work
GROUP BY style
ORDER BY COUNT(*) DESC
) 																										-- with CTE
SELECT 
'Most_Popular_Style' AS Top_3,
style,
No_Of_Style
FROM CTE_Style
WHERE RankStyle <= 3

UNION ALL

SELECT 
'Least_Popular_Style' AS Top_3,
style,
No_Of_Style
FROM CTE_Style
WHERE RankStyle2 <= 3;