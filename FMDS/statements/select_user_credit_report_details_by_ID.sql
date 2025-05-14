-- ===============================
-- * Select a specific user's credit report details by User_ID
-- ===============================
SELECT
    cr.User_ID,
    u.Full_Name,
    u.SSN,
    u.Date_Of_Birth AS DOB,
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
    cr.Credit_Report_ID AS CR_ID,
    cr.Report_Date,
    cr.Credit_Bureau_Name,
    cr.Credit_Score,
    cr.Credit_Description,
    u.Email AS User_Email,
    u.Phone_Number AS User_Phone_Number
FROM Credit_Report cr
    JOIN User u ON cr.User_ID = u.User_ID
WHERE
    cr.User_ID = 3
    AND cr.Credit_Bureau_Name = 'Equifax'
ORDER BY cr.User_ID ASC, cr.Report_Date DESC;
-- ===============================