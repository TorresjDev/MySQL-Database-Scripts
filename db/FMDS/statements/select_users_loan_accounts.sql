-- ===============================
-- * Select Users Loan Accounts
-- ===============================
SELECT
   la.Account_ID,
   fa.User_ID,
   u.Full_Name,
   u.Email,
   u.Phone_Number,
   fa.Institution_Name,
   fa.Account_Type,
   fa.Account_Name,
   fa.Account_Number,
   la.Loan_Amount,
   la.Loan_Term,
   la.Interest_Rate,
   la.Exp_Monthly_Payment,
   la.Start_Date,
   la.Exp_End_Date,
   fa.Account_Balance,
   fa.Date_Account_Opened
FROM
   Loan_Account la
   JOIN Financial_Account fa ON la.Account_ID = fa.Account_ID
   JOIN User u ON fa.User_ID = u.User_ID
ORDER BY
   u.Full_Name ASC,
   fa.Institution_Name ASC;

-- ===============================