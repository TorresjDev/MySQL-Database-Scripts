-- ===============================
-- * Select users with SSN
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    u.Date_Of_Birth,
    CONCAT('**-***', RIGHT(u.SSN, 4)) AS Last_4,
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
    ) AS Full_Address
FROM User u
WHERE
    u.SSN IS NOT NULL
ORDER BY
    u.User_ID ASC;
-- ===============================