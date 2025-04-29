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
      CONSTRAINT FK_User_Credit FOREIGN KEY (User_ID) REFERENCES User(User_ID)
) Comment="Credit Report Entity";
-- ---------------------------------------------------------
-- * Credit Report Insert Statement
INSERT INTO Credit_Report (User_ID, Credit_Bureau_Name, Credit_Score, Report_Date, Credit_Description)
VALUES
(1, 'Equifax', 720, '2023-01-15', 'Good credit history with no late payments.'),
(2, 'Experian', 680, '2023-02-20', 'Average credit score with some late payments.'),
(3, 'TransUnion', 750, '2023-03-10', 'Excellent credit score with no negative marks.'),
(4, 'Equifax', 600, '2023-04-05', 'Poor credit history with multiple late payments.'),
(5, 'Experian', 520, '2023-05-12', 'Fair credit score with some negative marks.'),
(6, 'TransUnion', 570, '2023-06-18', 'Fair credit score with no negative marks.'),
(7, 'Equifax', 690, '2023-07-25', 'Good credit history with no late payments.'),
(8, 'Experian', 710, '2023-08-30', 'Good credit score with some late payments.'),
(9, 'TransUnion', 730, '2023-09-15', 'Excellent credit score with no negative marks.');
-- -- ---------------------------------------------------------
-- * Credit Report Select Statement
SELECT * FROM Credit_Report;