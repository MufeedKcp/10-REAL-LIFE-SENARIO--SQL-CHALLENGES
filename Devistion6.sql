SELECT 
	orderid,
    productid,
    orderdate,
    sales,
    MAX(sales) OVER () AS HighestSales,
    MIN(sales) OVER () AS LowestSales,
    sales - MIN(sales) OVER () AS MinDevistion,
    ABS(sales - MAX(sales) OVER ()) AS MaxDevistion
FROM orders