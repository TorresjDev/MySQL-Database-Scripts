-- ===============================
-- * Select Users Account Transaction Summary
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   fa.Account_Type,
   fa.Account_Name,
   t.Transaction_Type,
   COUNT(t.Transaction_ID) AS Transaction_Count,
   SUM(t.Amount) AS Total_Amount,
   MAX(t.Transaction_Timestamp) AS Most_Recent_Transaction,
   t.Payment_Method
FROM
   Transaction t
   JOIN Financial_Account fa ON t.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
GROUP BY
   u.User_ID,
   fa.Account_Type,
   fa.Account_Name,
   t.Transaction_Type,
   t.Payment_Method
ORDER BY
   u.Full_Name,
   Total_Amount DESC,
   Most_Recent_Transaction DESC;
-- ===============================