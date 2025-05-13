-- ===============================
-- * Select transactions by personal user accounts
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    u.Email,
    fa.Account_ID,
    fa.Account_Name,
    fa.Account_Type,
    fa.Institution_Name,
    CONCAT(
        '******',
        RIGHT(fa.Account_Number, 4)
    ) AS Account_Last_4,
    t.Transaction_ID,
    t.Transaction_Type,
    CONCAT('$', FORMAT(t.Amount, 2)) AS Transaction_Amount,
    DATE_FORMAT(
        t.Transaction_Timestamp,
        '%b %d, %Y @%h:%i%p'
    ) AS TIMESTAMP,
    t.Payment_Method,
    t.Payment_Category,
    LEFT(t.Short_Description, 50) AS Summary
FROM
    User u
    JOIN Financial_Account fa ON u.User_ID = fa.User_ID
    JOIN Transaction t ON fa.Account_ID = t.Account_ID
WHERE
    fa.Is_Business_Account = FALSE
ORDER BY t.Transaction_Timestamp DESC, u.Full_Name ASC;
-- ===============================