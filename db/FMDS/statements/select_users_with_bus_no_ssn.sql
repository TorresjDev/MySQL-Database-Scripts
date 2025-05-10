-- ===============================
-- * Select users with business and no SSN
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    u.Date_Of_Birth,
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
    CASE 
      WHEN u.SSN IS NULL THEN 'No'
      ELSE 'Yes'
    END AS Has_SSN
FROM User u
WHERE
    u.SSN IS NULL
    AND u.Has_Business = TRUE
ORDER BY u.User_ID ASC;
-- ===============================