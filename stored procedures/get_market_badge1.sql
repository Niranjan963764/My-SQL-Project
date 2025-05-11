CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge1`(
	   IN Input_Market VARCHAR(45),    # IN & OUT stand for indicating whether it's a input parameter or output parameter
       IN Input_Fiscal_year YEAR,
       OUT Out_Market VARCHAR(45),
       OUT Sold_Quantity INT,
       OUT Output_badge VARCHAR(45)
)
BEGIN
	# Query to GET the Total_sold_quantity
	DECLARE total_sold_quantity INT DEFAULT 0;
     
    # Query to set Default market india
    IF Input_Market = " " THEN
			SET Input_market = "India";
	END IF;
     
	#Query to Get total sold Quantity x
	SELECT  dc.market, 
            SUM(fsm.sold_quantity) INTO Out_Market, total_sold_quantity
	 FROM fact_sales_monthly fsm
     JOIN dim_customer dc USING(Customer_code)
     WHERE dc.market = Input_Market AND get_fiscal_year(fsm.date) = Input_Fiscal_year
     GROUP BY dc.market;
     
     SET Sold_Quantity = Total_sold_quantity;
     
  # Query to GET output badge whether it's GOLD or Silver
	 IF total_sold_quantity > 5000000 THEN
			SET Output_badge = "GOLD";
     ELSE 
		    SET Output_badge = "SILVER";
     END IF;
END