SELECT *
FROM(
	SELECT 
	orderid,
	productid,
	sales,
	ROW_NUMBER() OVER (PARTITION BY productid ORDER BY sales DESC) AS HighestProductSale
FROM orders
) AS t
WHERE HighestProductSale = 1;