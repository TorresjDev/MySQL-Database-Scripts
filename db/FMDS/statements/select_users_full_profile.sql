-- ===============================
-- * Select users full profile
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    u.Date_Of_Birth,
    TIMESTAMPDIFF(
        YEAR,
        u.Date_Of_Birth,
        CURDATE()
    ) AS Age,
    CASE
        WHEN u.SSN IS NOT NULL THEN CONCAT('****-**-', RIGHT(u.SSN, 4))
        ELSE 'N/A'
    END AS SSN,
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
    CASE
        WHEN u.Has_Business = TRUE THEN 'Yes'
        ELSE 'No'
    END AS Has_Business,
    DATE_FORMAT(u.Created_At, '%m/%d/%Y') AS Member_Since
FROM User u
ORDER BY u.User_ID DESC;
-- ===============================