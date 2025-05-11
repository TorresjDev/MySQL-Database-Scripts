-- ===============================
-- * Select Users Credit Accounts
-- ===============================
SELECT
   ca.Account_ID,
   fa.User_ID,
   u.Full_Name,
   u.Email,
   u.Phone_Number,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Number,
   ca.Credit_Card_Number,
   ca.Credit_Limit,
   ca.Interest_Rate,
   ca.Billing_Cycle_Due_Date,
   ca.Card_Expiration_Date,
   fa.Account_Balance,
   fa.Date_Account_Opened
FROM
   Credit_Account ca
   JOIN Financial_Account fa ON ca.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
ORDER BY
   u.Full_Name ASC,
   fa.Institution_Name ASC;
-- ===============================