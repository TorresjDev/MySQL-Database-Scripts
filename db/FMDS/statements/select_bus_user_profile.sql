-- ===============================
-- * Select Business User Profile
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    CASE
        WHEN u.SSN IS NOT NULL THEN CONCAT('****-**-', RIGHT(u.SSN, 4))
        ELSE 'N/A'
    END AS SSN,
    u.Date_Of_Birth,
    TIMESTAMPDIFF(
        YEAR,
        u.Date_Of_Birth,
        CURDATE()
    ) AS Age,
    u.Email,
    u.Phone_Number,
    CONCAT_WS(
        ' ',
        u.Address_Line_1,
        u.Address_Line_2,
        u.Street,
        u.City,
        u.State,
        u.Zip_Code,
        u.Country
    ) AS Full_Address,
    b.Business_ID,
    b.Business_Name,
    CONCAT('**-***', RIGHT(b.EIN, 4)) AS EIN_Last_4,
    b.Start_Of_Business AS Business_Established,
    TIMESTAMPDIFF(
        YEAR,
        b.Start_Of_Business,
        CURDATE()
    ) AS Business_Age,
    DATE_FORMAT(b.Created_At, '%M %d, %Y') AS Business_Registered_Since,
    b.Business_Phone,
    b.Business_Email,
    (
        SELECT COUNT(*)
        FROM Financial_Account fa
        WHERE
            fa.User_ID = u.User_ID
            AND fa.Is_Business_Account = TRUE
    ) AS Number_Of_Fin_Accounts
FROM User u
    JOIN Business_User b ON u.User_ID = b.User_ID
WHERE
    u.Has_Business = TRUE
ORDER BY u.Full_Name ASC;
-- ===============================
