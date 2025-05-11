CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `post_invdis_pct` AS
    SELECT 
        `fidp`.`date` AS `date`,
        `fidp`.`product_code` AS `product_code`,
        `fidp`.`customer_code` AS `customer_code`,
        `fidp`.`variant` AS `variant`,
        `fidp`.`sold_quantity` AS `sold_quantity`,
        `fidp`.`product` AS `product`,
        `fidp`.`gross_price` AS `gross_price`,
        `fidp`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        (`fidp`.`Total_gross_price` - (`fidp`.`Total_gross_price` * `fidp`.`pre_invoice_discount_pct`)) AS `Net_invoice_sale`,
        (`foid`.`discounts_pct` + `foid`.`other_deductions_pct`) AS `post_invoice_dsc_pct`,
        ROUND((`fidp`.`gross_price` * `fidp`.`sold_quantity`),
                2) AS `Total_gross_price`
    FROM
        (`pre_invdic_pct` `fidp`
        JOIN `fact_post_invoice_deductions` `foid` ON (((`fidp`.`customer_code` = `foid`.`customer_code`)
            AND (`fidp`.`product_code` = `foid`.`product_code`)
            AND (`fidp`.`date` = `foid`.`date`))))