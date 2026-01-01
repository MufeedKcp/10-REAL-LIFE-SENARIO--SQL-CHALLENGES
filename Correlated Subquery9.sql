SELECT 
customers.customerid,
COALESCE(CONCAT(firstname, ' ',lastname), firstname) AS FullName,
country,
score, 
(	SELECT 
    COUNT(*) 
    FROM orders
    WHERE customers.customerid = orders.customerid -- need some info from main query to perform correlated subquery
) AS TotalOrders
FROM customers 