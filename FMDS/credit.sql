-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ? CREDIT_REPORT – Strong Entity
-- ---------------------------------------------------------
-- -- * Create Credit Report Entity
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
);
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
