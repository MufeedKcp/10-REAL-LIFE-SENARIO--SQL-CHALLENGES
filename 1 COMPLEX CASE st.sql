SELECT 
category, 
SUM(sales) TotalSales
FROM ( 
		SELECT sales,
		CASE
			WHEN sales > 50 THEN 'high'
			WHEN sales BETWEEN 20 AND 50 THEN 'medium'
			ELSE 'low'
		END AS category
        FROM orders
) AS t
GROUP BY category 
ORDER BY TotalSales DESC