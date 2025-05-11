CREATE VIEW `pre_invoice_discount_pct` AS 

SELECT * FROM fact_sales_monthly;


SELECT fsm.date , fsm.product_code, fsm.customer_code, 
	   variant, sold_quantity, product, gross_price ,
       pre_invoice_discount_pct, 
       ROUND((gross_price * sold_quantity), 2) AS Total_gross_price
FROM fact_sales_monthly fsm
JOIN dim_product d_p USING(product_code)
JOIN fact_gross_price fgp 
			on fgp.product_code = fsm.product_code and 
            fgp.fiscal_year = get_fiscal_year(fsm.date) 
JOIN fact_pre_invoice_deductions fpid
			on fsm.customer_code = fpid.customer_code and
            get_fiscal_year(fsm.date) = fpid.fiscal_year
WHERE fsm.customer_code = "90002002" AND
      get_fiscal_year(date) = 2021
   -- get_fiscal_Quarter(date) = "Q1"
ORDER BY date;

