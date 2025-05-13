-- ========================================
-- * Select User Credit Report Summary
-- ========================================
SELECT
    u.User_ID,
    u.Full_Name,
    CONCAT('****-**-', RIGHT(u.SSN, 4)) AS SSN_Last_4,
    u.Email,
    u.Phone_Number,
    DATE_FORMAT(u.Date_Of_Birth, '%b %d, %Y') AS DOB,
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
    cr.Credit_Bureau_Name,
    cr.Credit_Score,
    CASE
        WHEN cr.Credit_Score >= 750 THEN 'Excellent'
        WHEN cr.Credit_Score >= 700 THEN 'Good'
        WHEN cr.Credit_Score >= 650 THEN 'Fair'
        ELSE 'Poor'
    END AS Score_Rating,
    DATE_FORMAT(cr.Report_Date, '%M %d, %Y') AS Report_Date,
    LEFT(cr.Credit_Description, 80) AS Notes_Preview,
    (
        SELECT MAX(cr2.Credit_Score)
        FROM Credit_Report cr2
        WHERE
            cr2.User_ID = u.User_ID
    ) AS Highest_Score
FROM Credit_Report cr
    JOIN User u ON cr.User_ID = u.User_ID
WHERE
    u.SSN IS NOT NULL
ORDER BY u.Full_Name ASC, cr.Report_Date DESC;
-- ========================================