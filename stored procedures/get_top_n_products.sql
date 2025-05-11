CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products`(
       IN input_fiscal_year YEAR,
       IN input_top_n INT
)
BEGIN
	   SELECT product,
	   ROUND(SUM(Net_sales) / 1000000,2 ) AS Net_sales_mln
       FROM net_sales
	   WHERE get_fiscal_year(date) = input_fiscal_year			 
	   GROUP BY product
	   ORDER BY Net_sales_mln DESC
       LIMIT input_top_n;
END