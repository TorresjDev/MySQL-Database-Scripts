-- ===============================
-- * Select Users Spending Transactions
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   t.Payment_Category,
   COUNT(t.Transaction_ID) AS Transactions,
   SUM(t.Amount) AS Total_Spent
FROM
   Transaction t
   JOIN Financial_Account fa ON t.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
WHERE
   t.Transaction_Type = 'Withdrawal'
   OR t.Transaction_Type = 'Payment'
GROUP BY
   u.User_ID,
   t.Payment_Category
ORDER BY
   u.Full_Name,
   Total_Spent DESC;
-- ===============================