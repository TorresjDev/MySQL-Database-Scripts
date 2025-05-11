-- ===============================
-- * Select users with no SSN and no business
-- ===============================
SELECT u.User_ID,
       u.Full_Name,
       u.Date_Of_Birth, 
       u.SSN, u.Email, 
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
    u.SSN IS NULL
    AND u.Has_Business = FALSE
ORDER BY u.User_ID DESC;
-- ===============================
