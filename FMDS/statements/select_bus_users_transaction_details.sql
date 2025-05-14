-- ===============================
-- * Select Business Users Transaction Details
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   b.Business_ID,
   b.Business_Name,
   fa.Account_ID,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Balance,
   t.Transaction_ID,
   t.Transaction_Type,
   t.Payment_Method,
   t.Payment_Category,
   t.Short_Description,
   t.Amount,
   t.Transaction_Timestamp
FROM
   User u
   JOIN Business_User b ON u.User_ID = b.User_ID
   JOIN Financial_Account fa ON u.User_ID = fa.User_ID
   JOIN Transaction t ON fa.Account_ID = t.Account_ID
WHERE
   fa.Is_Business_Account = TRUE
ORDER BY
   u.Full_Name,
   fa.Account_ID,
   t.Transaction_Timestamp ASC;
-- ===============================