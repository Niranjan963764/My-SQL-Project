CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_markets`(
       IN input_fiscal_year YEAR,
       IN input_top_n INT
)
BEGIN
		SELECT Market,
       round(sum(Net_sales)/1000000, 2) AS net_sales_mln
       FROM net_sales ns
       JOIN dim_customer dc on dc.customer_code = ns.customer_code
	   WHERE get_fiscal_year(ns.date)= input_fiscal_year              
       GROUP BY Market
       ORDER BY Net_sales_mln DESC
       LIMIT input_top_n;
	   END