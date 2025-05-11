-- ===============================
-- * Financial Account - Super Type Entity
-- ===============================
CREATE TABLE Financial_Account (
    Account_ID INT NOT NULL AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Institution_Name VARCHAR(100) NOT NULL,
    Account_Type VARCHAR(30) NOT NULL CHECK (
        Account_Type IN (
            'Bank',
            'Loan',
            'Investment',
            'Digital Asset',
            'Credit'
        )
    ),
    Account_Name VARCHAR(100) NOT NULL,
    Account_Number VARCHAR(30) UNIQUE NOT NULL,
    Account_Balance DECIMAL(12, 2) NOT NULL,
    Date_Account_Opened DATE NOT NULL,
    Is_Business_Account BOOLEAN DEFAULT FALSE,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Financial_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_User_Account FOREIGN KEY (User_ID) REFERENCES User (User_ID)
);
-- ===============================