SELECT *,
	ROUND(AVG(DaysBtwOrders) OVER (PARTITION BY customerid), 0) AS AvgDaysBtwOrders
FROM(
SELECT *,
	DATEDIFF(NextOrderDate, CurrentOrderDate) AS DaysBtwOrders
FROM(
	SELECT 
	customerid,
	orderdate AS CurrentOrderDate,
	LEAD(orderdate) OVER (PARTITION BY customerid ORDER BY orderdate) AS NextOrderDate
	FROM orders
) AS t
) AS t