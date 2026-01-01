SELECT *, 
TotalSales - PrevMonth AS MoM_Perf,
ROUND((TotalSales - PrevMonth)/ PrevMonth * 100, 2) AS Percec
FROM(
SELECT 
	MONTH(orderdate) AS Month,
	SUM(sales) AS TotalSales,
	LAG(SUM(sales)) OVER (ORDER BY MONTH(orderdate)) AS PrevMonth
FROM orders
GROUP BY MONTH(orderdate)
) AS t