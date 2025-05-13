-- ===============================
-- * Select Users Investment Accounts
-- ===============================
SELECT
   ia.Account_ID,
   fa.User_ID,
   u.Full_Name,
   u.Email,
   u.Phone_Number,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Number,
   ia.Buying_Power,
   ia.Cash_Balance,
   ia.Total_User_Contribution,
   ia.Total_Investment_Value,
   ia.Total_Dividends_Earned,
   ia.Total_Interest_Earned,
   fa.Account_Balance,
   fa.Date_Account_Opened
FROM
   Investment_Account ia
   JOIN Financial_Account fa ON ia.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
ORDER BY
   u.Full_Name ASC,
   fa.Institution_Name ASC;
-- ===============================