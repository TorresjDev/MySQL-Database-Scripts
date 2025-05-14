-- ===============================
-- * Credit Account - Sub Type Entity of Financial Account
-- ===============================
CREATE TABLE Credit_Account (
    Account_ID INT NOT NULL,
    Credit_Card_Number VARCHAR(25) NOT NULL,
    Credit_Limit DECIMAL(12, 2) NOT NULL,
    Interest_Rate DECIMAL(5, 2) NOT NULL,
    Billing_Cycle_Due_Date DATE NOT NULL,
    Card_Expiration_Date CHAR(7) NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Credit_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Credit FOREIGN KEY (Account_ID) REFERENCES Financial_Account (Account_ID)
);
-- ===============================