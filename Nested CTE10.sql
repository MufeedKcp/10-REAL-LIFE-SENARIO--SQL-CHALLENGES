WITH CTE_Total_Sales AS (  										
	SELECT 
    customerid,
    SUM(sales) AS TotalSale								 -- Standalone CTE
    FROM orders
    GROUP BY customerid
) 
, CTE_Last_Order AS (   
	SELECT
    customerid,
    MAX(orderdate) AS LastDate								-- Multiple CTE
	FROM orders
    GROUP BY customerid
) 
, CTE_Rank AS (   
	SELECT 
    customerid,								
    RANK() 													-- Nested CTE
    OVER (ORDER BY TotalSale DESC) AS TotalSalesRank     
    FROM CTE_Total_Sales
)
, CTE_customer_seg AS (
	SELECT 
    customerid,
    	CASE 
		WHEN TotalSale > 100 THEN 'High'
        WHEN TotalSale > 80 THEN 'Medium'
        ELSE 'Low'
	END  AS Cust_Seg_Rank
    FROM  CTE_Total_Sales
)
SELECT 
	c.customerid,
	c.firstname,
	COALESCE(c.lastname, c.firstname) AS Lastname,
	lo.LastDate,
    cte.TotalSale,
    r.TotalSalesRank,
    sg.Cust_Seg_Rank
FROM customers c

LEFT JOIN CTE_Total_Sales cte
	ON c.customerid = cte.customerid
    
LEFT JOIN CTE_Last_Order  lo
	ON lo.customerid = c.customerid
    
LEFT JOIN CTE_Rank r
	ON r.customerid = c.customerid
    
LEFT JOIN CTE_customer_seg sg
	ON sg.customerid = c.customerid
    
ORDER BY IFNULL(r.TotalSalesRank, 99999) ASC