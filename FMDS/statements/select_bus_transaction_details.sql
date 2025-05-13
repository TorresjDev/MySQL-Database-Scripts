-- ===============================
-- * Select Business Transaction Details
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name AS Business_Account_Owner,
    b.Business_ID,
    b.Business_Name,
    fa.Account_ID,
    fa.Institution_Name,
    fa.Account_Type,
    CONCAT(
        '******',
        RIGHT(fa.Account_Number, 4)
    ) AS Account_Last_4,
    fa.Account_Name,
    t.Transaction_ID,
    t.Transaction_Type,
    CONCAT('$', FORMAT(t.Amount, 2)) AS Transaction_Amount,
    DATE_FORMAT(
        t.Transaction_Timestamp,
        '%b %d, %Y at %h:%i %p'
    ) AS TIMESTAMP,
    t.Payment_Method,
    t.Payment_Category,
    LEFT(t.Short_Description, 50) AS Summary
FROM
    User u
    JOIN Business_User b ON u.User_ID = b.User_ID
    JOIN Financial_Account fa ON u.User_ID = fa.User_ID
    JOIN Transaction t ON fa.Account_ID = t.Account_ID
WHERE
    fa.Is_Business_Account = TRUE
ORDER BY b.Business_Name ASC, t.Transaction_Timestamp DESC;
-- ===============================
