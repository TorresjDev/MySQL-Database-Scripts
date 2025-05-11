-- ===============================
-- * Select Business User Accounts Details
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    b.Business_ID,
    b.Business_Name,
    CONCAT('**-***', RIGHT(b.EIN, 4)) AS EIN_Last_4,
    b.Business_Phone,
    b.Business_Email,
    fa.Account_ID,
    fa.Institution_Name,
    fa.Account_Type,
    fa.Account_Name,
    CONCAT(
        '******',
        RIGHT(fa.Account_Number, 4)
    ) AS Account_Number_Last_4,
    CONCAT(
        '$',
        FORMAT(fa.Account_Balance, 2)
    ) AS Account_Balance,
    DATE_FORMAT(
        fa.Date_Account_Opened,
        '%b %d, %Y'
    ) AS Opened_On,
    TIMESTAMPDIFF(
        YEAR,
        fa.Date_Account_Opened,
        CURDATE()
    ) AS Account_Age_Years,
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
FROM
    User u
    JOIN Business_User b ON u.User_ID = b.User_ID
    JOIN Financial_Account fa ON u.User_ID = fa.User_ID
WHERE
    fa.Is_Business_Account = TRUE
ORDER BY b.Business_Name ASC, fa.Account_Balance DESC;
-- ===============================
