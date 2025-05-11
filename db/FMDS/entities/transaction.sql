-- ===============================
-- * Transaction - Supertype Entity
-- ===============================
CREATE TABLE Transaction (
    Transaction_ID INT NOT NULL AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Transaction_Type VARCHAR(30) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Transaction_Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    Payment_Method VARCHAR(50),
    Payment_Category VARCHAR(50),
    Short_Description TEXT,
    CONSTRAINT PK_Transaction PRIMARY KEY (Transaction_ID),
    CONSTRAINT FK_Account_Transaction FOREIGN KEY (Account_ID) REFERENCES Financial_Account (Account_ID),
    CONSTRAINT UQ_Transaction UNIQUE (
        Account_ID,
        Transaction_Type,
        Amount,
        Transaction_Timestamp,
        Payment_Method
    )
);
-- ===============================