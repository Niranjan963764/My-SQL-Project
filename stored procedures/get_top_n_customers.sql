CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_customers`(
		IN Input_fiscal_year YEAR,
		IN input_market VarchAR(45),
        IN input_top_n INT
)
BEGIN
	   SELECT Customer,
	   ROUND(SUM(Net_sales) / 1000000, 2) AS Net_sales_mln
       FROM net_sales ns
       JOIN dim_customer dc on ns.customer_code = dc.customer_code
       WHERE get_fiscal_year(ns.date) = input_fiscal_year AND
             Market = input_market
       GROUP BY  Customer
       ORDER BY Net_sales_mln DESC
       LIMIT input_top_n;
END