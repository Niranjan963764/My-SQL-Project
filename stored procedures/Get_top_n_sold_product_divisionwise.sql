CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_top_n_sold_product_divisionwise`(
           IN Input_top_n INT,
           IN input_fiscal_year YEAR
)
BEGIN
WITH Cte1 AS (SELECT dp.division,
	   dp.product,
	   sum(sold_quantity) AS total_quantity
	   FROM fact_sales_monthly fsm
       JOIN dim_product dp using(product_code)
       WHERE get_fiscal_year(fsm.date) = input_fiscal_year
       GROUP BY product),
CTE2 AS(
		SELECT *,
		DENSE_RANK() OVER (PARTITION BY division ORDER BY Total_quantity DESC) AS Rankx
        FROM cte1
        )
        
SELECT *		
from cte2
WHERE rankx <= input_top_n;
END