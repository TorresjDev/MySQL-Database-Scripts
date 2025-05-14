-- ===============================
-- * Select Users Investments and Digital Assets Overview
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   COALESCE(SUM(DISTINCT ia.Total_Investment_Value), 0) AS Total_Investment_Value,
   COALESCE(SUM(DISTINCT daa.Total_Digital_Assets_Value), 0) AS Total_Digital_Value,
   COALESCE(SUM(DISTINCT ia.Total_Investment_Value), 0) + COALESCE(SUM(DISTINCT daa.Total_Digital_Assets_Value), 0) AS Total_Portfolio_Value
FROM
   User u
   LEFT JOIN Financial_Account fa1 ON u.User_ID = fa1.User_ID
   AND fa1.Account_Type = 'Investment'
   LEFT JOIN Investment_Account ia ON fa1.Account_ID = ia.Account_ID
   LEFT JOIN Financial_Account fa2 ON u.User_ID = fa2.User_ID
   AND fa2.Account_Type = 'Digital Asset'
   LEFT JOIN Digital_Asset_Account daa ON fa2.Account_ID = daa.Account_ID
GROUP BY
   u.User_ID
ORDER BY
   Total_Portfolio_Value DESC;
-- ===============================