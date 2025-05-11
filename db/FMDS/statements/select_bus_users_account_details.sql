-- ===============================
-- * Select Business Users Account Details
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   u.Email,
   b.Business_ID,
   b.Business_Name,
   fa.Account_ID,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Balance,
   fa.Date_Account_Opened
FROM
   User u
   JOIN Business_User b ON u.User_ID = b.User_ID
   JOIN Financial_Account fa ON u.User_ID = fa.User_ID
WHERE
   u.Has_Business = TRUE
ORDER BY
   u.Full_Name ASC,
   fa.Account_Type ASC;
-- ===============================