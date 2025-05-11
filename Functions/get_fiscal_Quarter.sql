CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_Quarter`(
	calender_date DATE
) RETURNS varchar(2) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE MONTH_NAME INT;
    DECLARE Quarter VARCHAR(5);
    SET MONTH_NAME =  MONTH(DATE_ADD(calender_date, INTERVAL 4 MONTH));
    SET Quarter =  CASE
                      WHEN MONTH_NAME <=3 THEN "Q1"
                      WHEN MONTH_NAME BETWEEN 4 AND 6 THEN "Q2"
                      WHEN MONTH_NAME BETWEEN 7 AND  9  THEN "Q3"
                      ELSE "Q4"
				  END;
    
RETURN Quarter;
END