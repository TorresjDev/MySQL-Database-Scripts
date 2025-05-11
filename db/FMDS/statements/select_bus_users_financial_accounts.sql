-- ===============================
-- * Select Business Users Financial Accounts
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   b.Business_Name,
   fa.Account_ID,
   fa.Account_Type,
   fa.Account_Balance,
   (
      SELECT
         COUNT(*)
      FROM
         Financial_Account fa2
      WHERE
         fa2.User_ID = u.User_ID
   ) AS Total_Business_Accounts
FROM
   User u
   JOIN Business_User b ON u.User_ID = b.User_ID
   JOIN Financial_Account fa ON u.User_ID = fa.User_ID
WHERE
   u.Has_Business = TRUE
ORDER BY
   u.Full_Name,
   fa.Account_Type;
-- ===============================