SELECT 
	orderid,
	productid,
	DATE_FORMAT(orderdate, '%b %y') AS OrderMonth,
	sales,
	AVG(sales) OVER (PARTITION BY productid) AS AvgSales,
	AVG(sales) OVER (PARTITION BY productid ORDER BY orderdate) AS MovingAvgSales,
	AVG(sales) OVER (PARTITION BY productid ORDER BY orderdate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvgSales
FROM orders;
