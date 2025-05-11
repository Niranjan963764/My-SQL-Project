SELECT *, 
	   (Net_invoice_sale - Net_invoice_sale * post_invoice_dsc_pct) AS Net_Sales
FROM post_invdis_pct;