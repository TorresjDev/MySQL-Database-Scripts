-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? CREDIT_REPORT – Strong Entity
-- ---------------------------------------------------------
-- -- * Create Credit Report Entity

-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? Insert Statements
-- -- * Credit Report Insert Statement 
INSERT INTO Credit_Report (User_ID, Credit_Bureau_Name, Credit_Score, Report_Date, Credit_Description)
VALUES
(1, 'Equifax', 720, '2023-01-15', 'Good credit history'),
(1, 'Experian', 710, '2023-01-15', 'Good credit history'),
(1, 'TransUnion', 715, '2023-01-15', 'Good credit history'),
(3, 'Equifax', 680, '2023-02-20', 'Average credit history'),
(3, 'Experian', 690, '2023-02-20', 'Average credit history'),
(3, 'TransUnion', 685, '2023-02-20', 'Average credit history'),
(5, 'Equifax', 750, '2023-03-10', 'Excellent credit history'),
(5, 'Experian', 740, '2023-03-10', 'Excellent credit history'),
(5, 'TransUnion', 745, '2023-03-10', 'Excellent credit history');
-- ---------------------------------------------------------
-- ? Select Statements
-- * Credit Report Select Statement
SELECT * FROM Credit_Report;
-- -- ---------------------------------------------------------
-- -- * Select All Credit Reports by User_ID
SELECT cr.User_ID, u.Full_Name, u.SSN, u.Date_Of_Birth AS DOB, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address, cr.Credit_Report_ID AS CR_ID, cr.Report_Date, cr.Credit_Bureau_Name, cr.Credit_Score, cr.Credit_Description, u.Email as User_Email, u.Phone_Number as User_Phone_Number
FROM Credit_Report cr
JOIN User u ON cr.User_ID = u.User_ID ORDER BY cr.User_ID ASC, cr.Report_Date DESC;
-- -- * Select A Credit Report by User_ID
SELECT cr.User_ID, u.Full_Name, u.SSN, u.Date_Of_Birth AS DOB, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address, cr.Credit_Report_ID AS CR_ID, cr.Report_Date, cr.Credit_Bureau_Name, cr.Credit_Score, cr.Credit_Description, u.Email as User_Email, u.Phone_Number as User_Phone_Number
FROM Credit_Report cr
JOIN User u ON cr.User_ID = u.User_ID 
WHERE cr.User_ID = 3 AND cr.Credit_Bureau_Name = 'Equifax' ORDER BY cr.User_ID ASC, cr.Report_Date DESC
-- ---------------------------------------------------------


-- ✅ viii. Select Credit Report Info for Users with Valid SSNs
SELECT 
    u.User_ID,
    u.Full_Name,
    CONCAT('****-**-', RIGHT(u.SSN, 4)) AS SSN_Last_4,
    u.Email,
    u.Phone_Number,
    DATE_FORMAT(u.Date_Of_Birth, '%b %d, %Y') AS DOB,
    CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address,
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
    LEFT(cr.Credit_Description, 80) AS Notes,
    (
        SELECT MAX(Credit_Score)
        FROM Credit_Report cr2
        WHERE cr2.User_ID = u.User_ID
    ) AS Highest_Score
FROM Credit_Report cr
JOIN User u ON cr.User_ID = u.User_ID
WHERE u.SSN IS NOT NULL
ORDER BY u.Full_Name ASC, cr.Report_Date DESC;
