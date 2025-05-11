CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_Accuracy`(
			IN Fiscal_Year YEAR
)
BEGIN
		WITH forecast_act_estimate AS(
					SELECT  fsm.*,
							forecast_quantity
					FROM fact_sales_monthly fsm 
					JOIN fact_forecast_monthly ffm
						 USING(date, product_code, customer_code)
		     ), 
		     forecast_error_table AS(
					SELECT
							fae.customer_code AS customer_code,
							c.customer AS customer_name,
							c.market AS market,
							SUM(fae.sold_quantity) AS total_sold_qty,
							SUM(fae.forecast_quantity) AS total_forecast_qty,
							SUM(fae.forecast_quantity-fae.sold_quantity) AS net_error,
							ROUND(SUM(fae.forecast_quantity-fae.sold_quantity)*100/SUM(fae.forecast_quantity),1) AS net_error_pct,
							SUM(abs(fae.forecast_quantity-fae.sold_quantity)) AS abs_error,
							ROUND(SUM(abs(fae.forecast_quantity-sold_quantity))*100/SUM(fae.forecast_quantity),2) AS abs_error_pct
					FROM forecast_act_estimate fae
					JOIN dim_customer c
					ON fae.customer_code = c.customer_code
					WHERE fae.fiscal_year= Fiscal_Year
					GROUP BY customer_code

)
SELECT 
	  *,
	  IF (abs_error_pct > 100, 0, 100.0 - abs_error_pct) AS forecast_accuracy
	  FROM forecast_error_table
	  ORDER BY forecast_accuracy DESC;
END