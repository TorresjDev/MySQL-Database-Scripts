-- ===============================
-- * Select Users Investment Holdings Summary
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   ih.Investment_Symbol,
   ih.Investment_Type,
   COUNT(ih.Holdings_ID) AS Total_Holdings,
   ROUND(SUM(ih.Total_Quantity), 0) AS Total_Shares_Held,
   SUM(ih.Holdings_Value) AS Total_Holdings_Value,
   SUM(ih.Realized_Gain_Or_Loss) AS Realized_Gains,
   SUM(ih.Unrealized_Gain_Or_Loss) AS Unrealized_Gains
FROM
   Investment_Holding ih
   JOIN Investment_Account ia ON ih.Account_ID = ia.Account_ID
   JOIN Financial_Account fa ON ia.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
GROUP BY
   u.User_ID,
   ih.Investment_Symbol,
   ih.Investment_Type
ORDER BY
   u.Full_Name,
   ih.Investment_Type;
-- ===============================