-- ===============================
-- * Select Users Digital Asset Accounts
-- ===============================
SELECT
   da.Account_ID,
   fa.User_ID,
   u.Full_Name,
   u.Email,
   u.Phone_Number,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Number,
   da.Digital_Account_Type,
   da.Wallet_Address,
   da.Total_User_Contribution,
   da.Total_Digital_Assets_Value,
   da.Total_Dividends_Earned,
   da.Total_Interest_Earned,
   fa.Account_Balance,
   fa.Date_Account_Opened
FROM
   Digital_Asset_Account da
   JOIN Financial_Account fa ON da.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
ORDER BY
   u.Full_Name ASC,
   fa.Institution_Name ASC;
-- ===============================