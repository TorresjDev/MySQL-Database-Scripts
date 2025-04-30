-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? CREDIT_REPORT – Strong Entity
CREATE TABLE Credit_Report (
      Credit_Report_ID INT NOT NULL AUTO_INCREMENT,
      User_ID INT NOT NULL,
      Credit_Bureau_Name VARCHAR(50) NOT NULL CHECK (Credit_Bureau_Name IN ('Equifax', 'Experian', 'TransUnion')),
      Credit_Score INT NOT NULL CHECK (Credit_Score BETWEEN 300 AND 850),
      Report_Date DATE NOT NULL,
      Credit_Description TEXT,
      Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      CONSTRAINT PK_Credit_Report PRIMARY KEY (Credit_Report_ID),
      CONSTRAINT FK_User_Credit FOREIGN KEY (User_ID) REFERENCES User(User_ID),
      CONSTRAINT UQ_User_Bureau_Date UNIQUE (User_ID, Credit_Bureau_Name, Report_Date)
) Comment="Credit Report Entity";
-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? Insert Statements
-- * Credit Report Insert Statement if User_ID has SSN
INSERT INTO Credit_Report (User_ID, Credit_Bureau_Name, Credit_Score, Report_Date, Credit_Description)
SELECT cr.User_ID, cr.Credit_Bureau_Name, cr.Credit_Score, cr.Report_Date, cr.Credit_Description
FROM (
      SELECT 5 AS USER_ID, 'Equifax' AS Credit_Bureau_Name, 720 AS Credit_Score, '2023-01-01' AS Report_Date, 'Good credit history with no late payments.' AS Credit_Description 
      UNION ALL
      SELECT 5, 'Experian', 710, '2023-02-01', 'Good credit history with no late payments.'
      UNION ALL
      SELECT 5, 'TransUnion', 730, '2023-03-01', 'Good credit history with no late payments.'
      UNION ALL
      SELECT 6, 'Equifax', 610, '2023-04-01', 'Fair credit score with some late payments.'
      UNION ALL
      SELECT 6, 'Experian', 620, '2023-05-01', 'Average credit score with no negative marks.'
      UNION ALL
      SELECT 6, 'TransUnion', 630, '2023-06-01', 'Fair credit score with some late payments.'
      UNION ALL
      SELECT 7, 'Equifax', 660, '2023-07-01', 'Fair credit score with no negative marks.'
      UNION ALL
      SELECT 7, 'Experian', 670, '2023-08-01', 'Average credit score with some late payments.'
      UNION ALL
      SELECT 7, 'TransUnion', 680, '2023-09-01', 'Fair credit score with no negative marks.'
      UNION ALL
      SELECT 8, 'Equifax', 720, '2023-10-01', 'Good credit history with no late payments.'
      UNION ALL
      SELECT 8, 'Experian', 730, '2023-11-01', 'Excellent credit score with no negative marks.'
      UNION ALL
      SELECT 8, 'TransUnion', 740, '2023-12-01', 'Good credit history with no late payments.'
) AS cr
JOIN User u ON cr.User_ID = u.User_ID
WHERE u.SSN IS NOT NULL;
-- -- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? Select Statements
-- * Credit Report Select Statement
SELECT * FROM Credit_Report;
SELECT * FROM User WHERE `SSN` IS NOT NULL ORDER BY `User_ID` ASC;
SELECT * FROM Credit_Report WHERE User_ID = 5;
-- -- ---------------------------------------------------------
-- -- * Select All Credit Reports for a Specific User with User Data
SELECT cr.User_ID, u.Full_Name, u.SSN, u.Date_Of_Birth AS DOB, CONCAT_WS(' ', u.Address_Line_1, u.Address_Line_2, u.Street, u.City, u.State, u.Zip_Code, u.Country) AS Full_Address, cr.Credit_Report_ID AS CR_ID, cr.Report_Date, cr.Credit_Bureau_Name, cr.Credit_Score, cr.Credit_Description, u.Email as User_Email, u.Phone_Number as User_Phone_Number
FROM Credit_Report cr
JOIN User u ON cr.User_ID = u.User_ID
WHERE u.SSN IS NOT NULL ORDER BY cr.User_ID ASC, cr.Report_Date DESC;
--WHERE cr.User_ID = 5;
-- ---------------------------------------------------------

