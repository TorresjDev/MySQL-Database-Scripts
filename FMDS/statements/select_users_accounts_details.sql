-- ===============================
-- * Select Users Accounts Details
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    u.Email,
    u.Phone_Number,
    CONCAT_WS(
        ', ',
        u.City,
        u.State,
        u.Zip_Code
    ) AS Location,
    fa.Account_ID,
    fa.Institution_Name,
    fa.Account_Type,
    fa.Account_Name,
    CONCAT(
        '******',
        RIGHT(fa.Account_Number, 4)
    ) AS Account_Ends_With,
    CONCAT(
        '$',
        FORMAT(fa.Account_Balance, 2)
    ) AS Account_Balance,
    DATE_FORMAT(
        fa.Date_Account_Opened,
        '%b %d, %Y'
    ) AS Opened_On,
    TIMESTAMPDIFF(
        MONTH,
        fa.Date_Account_Opened,
        CURDATE()
    ) AS Account_Age_Months,
    (
        SELECT COUNT(*)
        FROM Transaction t
        WHERE
            t.Account_ID = fa.Account_ID
    ) AS Total_Transactions
FROM User u
    JOIN Financial_Account fa ON u.User_ID = fa.User_ID
WHERE
    fa.Is_Business_Account = FALSE
ORDER BY u.Full_Name ASC, fa.Account_Balance DESC;
-- ===============================
