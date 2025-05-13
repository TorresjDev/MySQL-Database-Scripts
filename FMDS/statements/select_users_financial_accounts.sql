-- ===============================
-- * Select Users Financial Accounts
-- ===============================
SELECT
   fa.Account_ID,
   fa.User_ID,
   u.Full_Name,
   u.Email,
   u.Phone_Number,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Number,
   fa.Account_Balance,
   fa.Date_Account_Opened
FROM
   Financial_Account fa
   JOIN User u ON fa.User_ID = u.User_ID
ORDER BY
   u.Full_Name ASC,
   fa.Institution_Name ASC;
-- ===============================