-- ===============================
-- * Bank Account - Sub Type Entity of Financial Account
-- ===============================
CREATE TABLE Bank_Account (
    Account_ID INT NOT NULL,
    Routing_Number CHAR(9) NOT NULL,
    APY DECIMAL(5, 2),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT PK_Bank_Account PRIMARY KEY (Account_ID),
    CONSTRAINT FK_Financial_Account_Bank FOREIGN KEY (Account_ID) REFERENCES Financial_Account (Account_ID),
    CONSTRAINT UQ_Bank_Account UNIQUE (Account_ID, Routing_Number)
);
-- ===============================