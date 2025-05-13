-- ===============================
-- * Select Users Bank Accounts
-- ===============================
SELECT
   ba.Account_ID,
   fa.User_ID,
   u.Full_Name,
   u.Email,
   u.Phone_Number,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Number,
   ba.Routing_Number,
   fa.Account_Balance,
   ba.APY,
   fa.Date_Account_Opened
FROM
   Bank_Account ba
   JOIN Financial_Account fa ON ba.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
ORDER BY
   u.Full_Name ASC,
   fa.Institution_Name ASC;
-- ===============================
