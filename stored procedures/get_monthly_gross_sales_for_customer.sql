CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
		customer_code INT
)
BEGIN
	SELECT fsm.date, 
		   (gross_price * sold_quantity) AS total_gross_sales
	FROM fact_sales_monthly fsm
    JOIN fact_gross_price fgp on
		 fgp.product_code = fsm.product_code and
         fgp.fiscal_year = get_fiscal_year(fsm.date)
	WHERE fsm.customer_code = customer_code
    GROUP BY fsm.date
    ORDER BY fsm.date DESC; 

END