-- ===============================
-- * Loan Account - Sub Type Entity of Financial Account
-- ===============================
CREATE TABLE Loan_Account (
    Account_ID INT NOT NULL,
    Loan_Amount DECIMAL(12, 2) NOT NULL,
    Loan_Term INT NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Exp_Monthly_Payment DECIMAL(10, 2) NOT NULL,
    Start_Date DATE NOT NULL,
    Exp_End_Date DATE NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Loan_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Loan FOREIGN KEY (Account_ID) REFERENCES Financial_Account (Account_ID)
);
-- ===============================